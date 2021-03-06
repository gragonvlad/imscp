=head1 NAME

 Package::AntiRootkits::Chkrootkit::Installer - i-MSCP Chkrootkit package installer

=cut

# i-MSCP - internet Multi Server Control Panel
# Copyright (C) 2010-2019 by Laurent Declercq <l.declercq@nuxwin.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

package Package::AntiRootkits::Chkrootkit::Installer;

use strict;
use warnings;
use iMSCP::Debug qw/ debug error /;
use iMSCP::File;
use iMSCP::Execute 'execute';
use iMSCP::ProgramFinder;
use Servers::cron;
use parent 'Common::SingletonClass';

=head1 DESCRIPTION

 Chkrootkit package installer.

=head1 PUBLIC METHODS

=over 4

=item preinstall( )

 Process preinstall tasks

 Return int 0 on success, other on failure

=cut

sub preinstall
{
    my ( $self ) = @_;

    $self->_disableDebianConfig();
}

=item postinstall( )

 Process post install tasks

 Return int 0 on success, other on failure

=cut

sub postinstall
{
    my ( $self ) = @_;

    my $rs = $self->_addCronTask();
    $rs ||= $self->_scheduleCheck();
}

=back

=head1 PRIVATE METHODS

=over 4

=item _disableDebianConfig( )

 Disable default configuration as provided by the chkrootkit Debian package

 Return int 0 on success, other on failure

=cut

sub _disableDebianConfig
{
    return 0 unless -f '/etc/cron.daily/chkrootkit';

    iMSCP::File->new( filename => '/etc/cron.daily/chkrootkit' )->moveFile( '/etc/cron.daily/chkrootkit.disabled' );
}

=item _addCronTask( )

 Add cron task

 Return int 0 on success, other on failure

=cut

sub _addCronTask
{
    return 0 unless my $bin = iMSCP::ProgramFinder::find( 'chkrootkit' );

    Servers::cron->factory()->addTask( {
        TASKID  => 'Package::AntiRootkits::Chkrootkit',
        MINUTE  => '@weekly',
        HOUR    => '',
        DAY     => '',
        MONTH   => '',
        DWEEK   => '',
        USER    => $::imscpConfig{'ROOT_USER'},
        COMMAND => "nice -n 10 ionice -c2 -n5 bash $bin -e > $::imscpConfig{'CHKROOTKIT_LOG'} 2>&1"
    } );
}

=item _scheduleCheck( )

 Schedule check if log file doesn't exist or is empty

 Return int 0 on success, other on failure

=cut

sub _scheduleCheck
{
    return 0 if -f -s $::imscpConfig{'CHKROOTKIT_LOG'} || !( my $bin = iMSCP::ProgramFinder::find( 'chkrootkit' ) );

    # Create an empty file to avoid planning multiple check if installer is run
    # many time
    my $file = iMSCP::File->new( filename => $::imscpConfig{'CHKROOTKIT_LOG'} );
    $file->set( "Check scheduled...\n" );
    my $rs = $file->save();
    return $rs if $rs;

    $rs = execute( "echo 'bash $bin -e > $::imscpConfig{'CHKROOTKIT_LOG'} 2>&1' | at now + 10 minutes", \my $stdout, \my $stderr );
    debug( $stdout ) if $stdout;
    error( $stderr || 'Unknown error' ) if $rs;
    $rs;
}

=back

=head1 AUTHOR

 Laurent Declercq <l.declercq@nuxwin.com>

=cut

1;
__END__
