package HTML::Table;
use strict;

use 5.002;

use vars qw($VERSION);
$VERSION = '1.09';

use overload	'""'	=>	\&getTable,
				fallback => undef;

=head1 NAME

HTML::Table - produces HTML tables

=head1 SYNOPSIS

  use HTML::Table;

  $table1 = new HTML::Table($rows, $cols);
    or
  $table1 = new HTML::Table(-rows=>26,
                            -cols=>2,
                            -border=>1,
                            -bgcolor=>"blue",
                            -width=>"50\%",
                            -spacing=>1,
                            -padding=>1);

  $table1->setCell($cellrow, $cellcol, 'This is Cell 1');
  $table1->setCellBGColor('blue');
  $table1->setCellColSpan(1, 1, 2);
  $table1->setRowHead(1);
  $table1->setColHead(1);

  $table1->print;

  $table2 = new HTML::Table;
  $table2->addRow(@cell_values);
  $table2->addCol(@cell_values2);

  $table1->setCell(1,1, "$table2->getTable");
  $table1->print;

=head1 REQUIRES

Perl5.002

=head1 EXPORTS

Nothing

=head1 DESCRIPTION

HTML::Table is used to generate HTML tables for
CGI scripts.  By using the methods provided fairly
complex tables can be created, manipulated, then printed
from Perl scripts.  The module also greatly simplifies
creating tables within tables from Perl.  It is possible
to create an entire table using the methods provided and
never use an HTML tag.

HTML::Table also allows for creating dynamically sized
tables via its addRow and addCol methods.  These methods
automatically resize the table if passed more cell values
than will fit in the current table grid.

Methods are provided for nearly all valid table, row, and
cell tags specified for HTML 3.0.

A Japanese translation of the documentation is available at:

	http://member.nifty.ne.jp/hippo2000/perltips/html/table.htm


=head1 METHODS

  [] indicate optional parameters. default value will
     be used if no value is specified

=head2 Creation

=over 4

=item new HTML::Table([num_rows, num_cols])

Creates a new HTML table object.  If rows and columns
are specified, the table will be initialized to that
size.  Row and Column numbers start at 1,1.  0,0 is
considered an empty table.

=item new HTML::Table([-rows=>num_rows, 
		 -cols=>num_cols, 
		 -border=>border_width, 
		 -bgcolor=>back_colour, 
		 -width=>table_width, 
		 -spacing=>cell_spacing, 
		 -padding=>cell_padding])

Creates a new HTML table object.  If rows and columns
are specified, the table will be initialized to that
size.  Row and Column numbers start at 1,1.  0,0 is
considered and empty table.

=back

=head2 Table Level Methods

=over 4

=item setBorder([pixels])

Sets the table Border Width

=item setWidth([pixels|percentofscreen])

Sets the table width
Remember to escape percent symbol if used

=item setCellSpacing([pixels])

=item setCellPadding([pixels])

=item setCaption("CaptionText" [, TOP|BOTTOM])

=item setBGColor([colorname|colortriplet])

=item autoGrow([1|true|on|anything|0|false|off|no|disable])

Switches on (default) or off automatic growing of the table
if row or column values passed to setCell exceed current
table size.

=back

=head2 Cell Level Methods

=over 4

=item setCell(row_num, col_num, "content")

Sets the content of a table cell.  This could be any
string, even another table object via the getTable method.
If the row and/or column numbers are outside the existing table
boundaries extra rows and/or columns are created automatically.

=item setCellAlign(row_num, col_num, [CENTER|RIGHT|LEFT])

Sets the horizontal alignment for the cell.

=item setCellVAlign(row_num, col_num, [CENTER|TOP|BOTTOM])

Sets the vertical alignment for the cell.

=item setCellWidth(row_num, col_num, [pixels|percentoftable])

Sets the width of the cell.

=item setCellHeight(row_num, col_num, [pixels])

Sets the height of the cell.

=item setCellHead(row_num, col_num)

Sets cell to be of type head (Ie <TH></TH>)

=item setCellNoWrap(row_num, col_num, [0|1])

Sets the NoWrap attribute of the cell.

=item setCellBGColor(row_num, col_num, [colorname|colortriplet])

Sets the background colour for the cell

=item setCellRowSpan(row_num, col_num, num_cells)

Causes the cell to overlap a number of cells below it.
If the overlap number is greater than number of cells 
below the cell, a false value will be returned.

=item setCellColSpan(row_num, col_num, num_cells)

Causes the cell to overlap a number of cells to the right.
If the overlap number is greater than number of cells to
the right of the cell, a false value will be returned.

=item setCellSpan(upleft_row_num, up_left_col_num,
        lowright_row_num, lowrigt_col_num)

Joins the block of cells with the corners specified.
If the values specified are greater than the number of
rows or columns, a false value will be returned.

=item setCellFormat(row_num, col_num, start_string, end_string)

Start_string should be a string of valid HTML, which is output before
the cell contents, end_string is valid HTML that is output after the cell contents.
This enables formatting to be applied to the cell contents.

	$table->setCellFormat(1, 2, '<B>', '</B>');

=item getCell(row_num, col_num)

Returns the contents of the specified cell as a string.

=back

=head2 Column Level Methods

=over 4

=item addCol("cell 1 content" [, "cell 2 content",  ...])

Adds a column to the right end of the table.  Assumes if
you pass more values than there are rows that you want
to increase the number of rows.

=item setColAlign(col_num, [CENTER|RIGHT|LEFT])

Applies setCellAlign over the entire column.

=item setColVAlign(col_num, [CENTER|TOP|BOTTOM])

Applies setCellVAlign over the entire column.

=item setColWidth(col_num, [pixels|percentoftable])

Applies setCellWidth over the entire column.

=item setColHeight(col_num, [pixels])

Applies setCellHeight over the entire column.

=item setColHead(col_num)

Applies setCellHead over the entire column.

=item setColNoWrap(col_num, [0|1])

Applies setCellNoWrap over the entire column.

=item setColBGColor(row_num, [colorname|colortriplet])

Applies setCellBGColor over the entire column.

=item setColFormat(col_num, start_string, end_sting)

Applies setCellFormat over the entire column.

=back

=head2 Row Level Methods

=over 4

=item addRow("cell 1 content" [, "cell 2 content",  ...])

Adds a row to the bottom of the table.  Assumes if you
pass more values than there are columns that you want
to increase the number of columns.

=item setRowAlign(row_num, [CENTER|RIGHT|LEFT])

Applies setCellAlign over the entire row.

=item setRowVAlign(row_num, [CENTER|TOP|BOTTOM])

Applies setCellVAlign over the entire row.

=item setRowWidth(row_num, [pixels|percentoftable])

Applies setCellWidth over the entire row.

=item setRowHeight(row_num, [pixels])

Applies setCellHeight over the entire row.

=item setRowHead(row_num)

Applies setCellHead over the entire row.

=item setRowNoWrap(col_num, [0|1])

Applies setCellNoWrap over the entire row.

=item setRowBGColor(row_num, [colorname|colortriplet])

Applies setCellBGColor over the entire row.

=item setRowFormat(row_num, start_string, end_string)

Applies setCellFormat over the entire row.

=back

=head2 Output Methods

=over 4

=item getTable

Returns a string containing the HTML representation
of the table.

The same effect can also be achieved by using the object reference 
in a string scalar context.

For example...

	This code snippet:

		$table = new HTML::Table(2, 2);
		print '<P>Start</P>';
		print $table->getTable;
		print '<P>End</P>';

	would produce the same output as:

		$table = new HTML::Table(2, 2);
		print "<P>Start</P>$table<P>End</P>";

=item print

Prints HTML representation of the table to STDOUT

=back

=head1 CLASS VARIABLES

=head1 HISTORY

This module was originally created in 1997 by Stacy Lacy and whose last 
version was uploaded to CPAN in 1998.  The module was adopted in July 2000 
by Anthony Peacock in order to distribute a revised version.  This adoption 
took place without the explicit consent of Stacy Lacy as it proved impossible 
to contact them at the time.  Although explicit consent was not obtained at 
the time, there was some evidence that Stacy Lacy was looking for somebody 
to adopt the module in 1998.

=head1 AUTHOR

Anthony Peacock, a.peacock@chime.ucl.ac.uk
Stacy Lacy (Original author)

=head1 CONTRIBUTIONS

Jay Flaherty, fty@mediapulse.com
For ROW, COL & CELL HEAD methods. Modified the new method to allow hash of values.

John Stumbles, john@uk.stumbles.org
For autogrow behaviour of setCell, and allowing alignment specifications to be case insensitive

=head1 COPYRIGHT

Copyright (c) 1998-2001 Anthony Peacock, CHIME.
Copyright (c) 1997 Stacy Lacy

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

perl(1), CGI(3)

=cut

#  Internal Methods-------------------------------------------
#  _updateSpanGrid(row_num, col_num)
#  _getTableHashValues(tablehashname)
#  _is_integer(stringvalue)
#
# Documentation:
# Valid Netscape Navigator BGColors as of 07/30/1997
#
# 
# aliceblue antiquewhite aqua aquamarine azure azure [#F0FFFF] beige bisque 
# black blanchedalmond blue blueviolet brown burlywood cadetblue chartreuse 
# chocolate coral cornflowerblue cornsilk crimson cyan darkblue darkcyan 
# darkgoldenrod darkgray darkgreen darkkhaki darkmagenta darkolivegreen 
# darkorange darkorchid darkred darksalmon darkseagreen darkslateblue 
# darkslategray darkturquoise darkviolet deeppink deepskyblue dimgray 
# dodgerblue firebrick floralwhite forestgreen fuchsia gainsboro ghostwhite 
# gold goldenrod gray green greenyellow honeydew hotpink indianred indigo 
# ivory khaki lavender lavenderblush lawngreen lemonchiffon lightblue 
# lightcoral lightcyan lightgoldenrodyellow lightgreen lightgrey lightpink 
# lightsalmon lightseagreen lightskyblue lightslategray lightsteelblue 
# lightyellow lime limegreen linen magenta maroon mediumaquamarine 
# mediumblue mediumorchid mediumpurple mediumseagreen mediumslateblue 
# mediumspringgreen mediumturquoise mediumvioletred midnightblue mintcream 
# mistyrose moccasin navajowhite navy oldlace olive olivedrab orange 
# orangered orchid palegoldenrod palegreen paleturquoise palevioletred 
# papayawhip peachpuff peru pink plum powderblue purple red rosybrown 
# royalblue saddlebrown salmon sandybrown seagreen seashell sienna silver 
# skyblue slateblue slategray snow springgreen steelblue tan teal thistle 
# tomato turquoise violet wheat white whitesmoke yellow yellowgreen 
#-------------------------------------------------------


#-------------------------------------------------------
# Subroutine:  	new([num_rows, num_cols])
#            or new([-rows=>num_rows,
#                   -cols=>num_cols,
#                   -border=>border_width,
#                   -bgcolor=>back_colour,
#                   -width=>table_width,
#                   -spacing=>cell_spacing,
#                   -padding=>cell_padding]); 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
# Modified:     30 Mar 1998 - Jay Flaherty
# Modified:     13 Feb 2001 - Anthony Peacock
#-------------------------------------------------------
sub new {

# Creates new table instance
my $type = shift;
my $class = ref($type) || $type;
my $self ={};
bless( $self, $class); 

# If paramter list is a hash (of the form -param=>value, ...)
if (defined $_[0] && $_[0] =~ /^-/) {
    my %flags = @_;
    $self->{rows} = $flags{-rows} || 0;
    $self->{cols} = $flags{-cols} || 0;
    $self->{border} = $flags{-border} || undef;
    $self->{bgcolor} = $flags{-bgcolor} || undef;
    $self->{background} = $flags{-background} || undef;
    $self->{width} = $flags{-width} || undef;
    $self->{cellspacing} = $flags{-spacing} || undef;
    $self->{cellpadding} = $flags{-padding} || undef;
}
else # user supplied row and col (or default to 0,0)
{
    $self->{rows} = shift || 0;
    $self->{cols} = shift || 0;
}

# let's initialize our empty table
$self->{table} = {};

# Table Auto-Grow mode (default on)
$self->{autogrow} = 1;

# Cell alignment is tracked in two mirror tables
$self->{"table:align"} = {};
$self->{"table:valign"} = {};

# Cell wrapping template
$self->{"table:nowrap"} = {};

# Cell width and height masks
$self->{"table:cellwidth"} = {};
$self->{"table:cellheight"} = {};

# Cell BG colors   
$self->{"table:cellbgcolor"} = {};

# Cell Row and Column Spanning masks
$self->{"table:cellrowspan"} = {};
$self->{"table:cellcolspan"} = {};
$self->{"table:cellspan"} = {};

# Cell Row header mask
$self->{"table:cellhead"} = {};

return $self;
}	

#-------------------------------------------------------
# Subroutine:  	getTable 
# Author:       Stacy Lacy	
# Date:		30 July 1997
# Modified:     19 Mar 1998 - Jay Flaherty
# Modified:     13 Feb 2001 - Anthony Peacock
#-------------------------------------------------------
sub getTable {
   my $self = shift;
   my $html="";

   # this sub returns HTML version of the table object
   if ((! $self->{rows}) || (! $self->{cols})) {
      return 0;  # no rows or no cols
   }
   $html .="<TABLE";
   $html .=" BORDER=$self->{border}" if defined $self->{border};
   $html .=" CELLSPACING=$self->{cellspacing}" if defined $self->{cellspacing};
   $html .=" CELLPADDING=$self->{cellpadding}" if defined $self->{cellpadding};
   $html .=" WIDTH=$self->{width}" if defined $self->{width};
   $html .=" BGCOLOR=$self->{bgcolor}" if defined $self->{bgcolor};
   $html .=" BACKGROUND=$self->{background}" if defined $self->{background};
   $html .=">\n";
   if (defined $self->{caption}) {
      $html .="<CAPTION";
      $html .=" ALIGN=$self->{caption_align}" if (defined $self->{caption_align});
      $html .=">$self->{caption}</CAPTION>\n";
   }

   my ($i, $j);
   for ($i=1;$i <= ($self->{rows});$i++){
      # Print each row of the table   
      $html .="<TR>";
      for ($j=1; $j <= ($self->{cols}); $j++) {
          
          if (defined $self->{"table:cellspan"}{"$i:$j"} && $self->{"table:cellspan"}{"$i:$j"} eq "SPANNED"){
             $html.="<!-- spanned cell -->";
             next
          }
          
          # print cell
          # if head flag is set print <TH> tag else <TD>
          if (defined $self->{"table:cellhead"}{"$i:$j"}) {
            $html .="<TH";
          } else { 
            $html .="<TD";
          }

          # if alignment options are set, add them in the cell tag
          $html .=" ALIGN=" . $self->{"table:align"}{"$i:$j"}
                if defined $self->{"table:align"}{"$i:$j"};
          
          $html .=" VALIGN=" . $self->{"table:valign"}{"$i:$j"}
                if defined $self->{"table:valign"}{"$i:$j"};
          
          # Apply custom height and width to the cell tag
          $html .=" WIDTH=" . $self->{"table:cellwidth"}{"$i:$j"}
                if defined $self->{"table:cellwidth"}{"$i:$j"};
          $html .=" HEIGHT=" . $self->{"table:cellheight"}{"$i:$j"}
                if defined $self->{"table:cellheight"}{"$i:$j"};
                    
          # apply background color if set
          $html .=" BGCOLOR=" . $self->{"table:cellbgcolor"}{"$i:$j"}
                if defined $self->{"table:cellbgcolor"}{"$i:$j"};

          # if NOWRAP mask is set, put it in the cell tag
          $html .=" NOWRAP" if defined $self->{"table:nowrap"}{"$i:$j"};
          
          # if column/row spanning is set, put it in the cell tag
          # also increment to skip spanned rows/cols.
          if (defined $self->{"table:cellcolspan"}{"$i:$j"}) {
            $html .=" COLSPAN=" . $self->{"table:cellcolspan"}{"$i:$j"};
          }
          if (defined $self->{"table:cellrowspan"}{"$i:$j"}){
            $html .=" ROWSPAN=" . $self->{"table:cellrowspan"}{"$i:$j"};
          }
          
          # Finish up Cell by ending cell start tag, putting content and cell end tag
          $html .=">";
          $html .= $self->{'table:cellstartformat'}{"$i:$j"} if defined $self->{'table:cellstartformat'}{"$i:$j"} ;
          $html .= $self->{table}{"$i:$j"} if defined $self->{table}{"$i:$j"};
		  $html .= $self->{'table:cellendformat'}{"$i:$j"} if defined $self->{'table:cellendformat'}{"$i:$j"} ;
          
          # if head flag is set print </TH> tag else </TD>
          if (defined $self->{"table:cellhead"}{"$i:$j"}) {
            $html .= "</TH>";
          } else {
            $html .= "</TD>";
          }
      }
      $html .="</TR>\n";
   }
   $html .="</TABLE>\n";

   return ($html);
}

#-------------------------------------------------------
# Subroutine:  	print
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub print {
   my $self = shift;
   print $self->getTable;
}

#-------------------------------------------------------
# Subroutine:  	autoGrow([1|on|true|0|off|false]) 
# Author:       John Stumbles
# Date:		08 Feb 2001
# Description:  switches on (default) or off auto-grow mode
#-------------------------------------------------------
sub autoGrow {
    my $self = shift;
    $self->{autogrow} = shift;
	if ( defined $self->{autogrow} && $self->{autogrow} =~ /^(?:no|off|false|disable|0)$/i ) {
	    $self->{autogrow} = 0;
	} else {
		$self->{autogrow} = 1;
	}
}


#-------------------------------------------------------
# Table config methods
# 
#-------------------------------------------------------

#-------------------------------------------------------
# Subroutine:  	setBorder([pixels]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
# Modified:     12 Jul 2000 - Anthony Peacock (To allow zero values)
#-------------------------------------------------------
sub setBorder {
    my $self = shift;
    $self->{border} = shift;
    $self->{border} = 1 unless ( &_is_integer($self->{border}) ) ;
}

#-------------------------------------------------------
# Subroutine:  	setBGColor([colorname|colortriplet]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setBGColor {
   my $self = shift;
   $self->{bgcolor} = shift || undef;
}

#-------------------------------------------------------
# Subroutine:  	setWidth([pixels|percentofscreen]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setWidth {
   my $self = shift;
   my $value = shift;
   
   if ( $value !~ /^\s*\d+%?/ ) {
      print STDERR "$0:setWidth:Invalid value $value\n";
      return 0;
   } else {
      $self->{width} = $value;
   }    
}

#-------------------------------------------------------
# Subroutine:  	setCellSpacing([pixels]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
# Modified:     12 Jul 2000 - Anthony Peacock (To allow zero values)
#-------------------------------------------------------
sub setCellSpacing {
    my $self = shift;
    $self->{cellspacing} = shift;
    $self->{cellspacing} = 1 unless ( &_is_integer($self->{cellspacing}) ) ;
}

#-------------------------------------------------------
# Subroutine:  	setCellPadding([pixels]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
# Modified:     12 Jul 2000 - Anthony Peacock (To allow zero values)
#-------------------------------------------------------
sub setCellPadding {
    my $self = shift;
    $self->{cellpadding} = shift;
    $self->{cellpadding} = 1 unless ( &_is_integer($self->{cellpadding}) ) ;
}

#-------------------------------------------------------
# Subroutine:  	setCaption("CaptionText" [, "TOP|BOTTOM]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setCaption {
   my $self = shift;
   $self->{caption} = shift ;
   my $align = uc(shift);
   if (defined $align && (($align eq 'TOP') || ($align eq 'BOTTOM')) ) {
      $self->{caption_align} = $align;
   } else {
      $self->{caption_align} = 'TOP';
   }
}

#-------------------------------------------------------
# Cell config methods
# 
#-------------------------------------------------------

#-------------------------------------------------------
# Subroutine:  	setCell(row_num, col_num, "content") 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
# Modified:     08 Feb 2001 - John Stumbles to allow auto-growing of table
#-------------------------------------------------------
sub setCell {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;

   if ($row < 1) {
      print STDERR "$0:setCell:Invalid table row reference $row:$col\n";
      return 0;
   }
   if ($col < 1) {
      print STDERR "$0:setCell:Invalid table column reference $row:$col\n";
      return 0;
   }
   if ($row > $self->{rows}) {
      if ($self->{autogrow}) {
        $self->{rows} = $row ;
      } else {
        print STDERR "$0:setCell:Invalid table row reference $row:$col\n";
      }
   }
   if ($col > $self->{cols}) {
      if ($self->{autogrow}) {
        $self->{cols} = $col ;
      } else {
        print STDERR "$0:setCell:Invalid table column reference $row:$col\n";
      }
   }
   $self->{table}{"$row:$col"} = shift;
   return ($row, $col);

}

#-------------------------------------------------------
# Subroutine:  	getCell(row_num, col_num) 
# Author:       Anthony Peacock	
# Date:		27 Jul 1998
#-------------------------------------------------------
sub getCell {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:getCell:Invalid table reference $row:$col\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:getCell:Invalid table reference $row:$col\n";
      return 0;
   }

   return $self->{table}{"$row:$col"} ;

}

#-------------------------------------------------------
# Subroutine:  	setCellAlign(row_num, col_num, [CENTER|RIGHT|LEFT]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
# Modified:     13 Feb 2001 - Anthony Peacock for case insensitive
#                             alignment parameters
#                             (suggested by John Stumbles)
#-------------------------------------------------------
sub setCellAlign {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   my $align = uc(shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellAlign:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellAlign:Invalid table reference\n";
      return 0;
   }

   if (! $align) {
      #return to default alignment if none specified
      undef $self->{"table:align"}{"$row:$col"};
      return ($row, $col);
   }

   if (! (($align eq "CENTER") || ($align eq "RIGHT") || 
          ($align eq "LEFT"))) {
      print STDERR "$0:setCellAlign:Invalid alignment type\n";
      return 0;
   }

   # We have a valid alignment type so let's set it for the cell
   $self->{"table:align"}{"$row:$col"} = $align;
   return ($row, $col);
}

#-------------------------------------------------------
# Subroutine:  	setCellVAlign(row_num, col_num, [CENTER|TOP|BOTTOM]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
# Modified:     13 Feb 2001 - Anthony Peacock for case insensitive
#                             alignment parameters
#                             (suggested by John Stumbles)
#-------------------------------------------------------
sub setCellVAlign {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   my $valign = uc(shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellVAlign:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellVAlign:Invalid table reference\n";
      return 0;
   }

   if (! $valign) {
      #return to default alignment if none specified
      undef $self->{"table:valign"}{"$row:$col"};
      return ($row, $col);
   }

   if (! (($valign eq "CENTER") || ($valign eq "TOP") || 
          ($valign eq "BOTTOM"))) {
      print STDERR "$0:setCellVAlign:Invalid alignment type\n";
      return 0;
   }

   # We have a valid valignment type so let's set it for the cell
   $self->{"table:valign"}{"$row:$col"} = $valign;
   return ($row, $col);
}

#-------------------------------------------------------
# Subroutine:  	setCellHead(row_num, col_num, [0|1]) 
# Author:       Jay Flaherty
# Date:		19 Mar 1998
#-------------------------------------------------------
sub setCellHead{
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   my $value = shift || 1;

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellHead:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellHead:Invalid table reference\n";
      return 0;
   }

   $self->{"table:cellhead"}{"$row:$col"} = $value;
   return ($row, $col);
}

#-------------------------------------------------------
# Subroutine:  	setCellNoWrap(row_num, col_num, [0|1]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setCellNoWrap {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   (my $value = shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellNoWrap:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellNoWrap:Invalid table reference\n";
      return 0;
   }


   $self->{"table:nowrap"}{"$row:$col"} = $value;
   return ($row, $col);
}

#-------------------------------------------------------
# Subroutine:  	setCellWidth(row_num, col_num, [pixels|percentoftable]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setCellWidth {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   (my $value = shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellWidth:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellWidth:Invalid table reference\n";
      return 0;
   }

   if (! $value) {
      #return to default alignment if none specified
      undef $self->{"table:height"}{"$row:$col"};
      return ($row, $col);
   }

   if ( $value !~ /^\s*\d+%?/ ) {
      print STDERR "$0:setCellWidth:Invalid value $value\n";
      return 0;
   } else {
      $self->{"table:cellwidth"}{"$row:$col"} = $value;
      return ($row, $col);
   }
}

#-------------------------------------------------------
# Subroutine:  	setCellHeight(row_num, col_num, [pixels]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setCellHeight {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   (my $value = shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellHeight:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellHeight:Invalid table reference\n";
      return 0;
   }

   if (! $value) {
      #return to default alignment if none specified
      undef $self->{"table:cellheight"}{"$row:$col"};
      return ($row, $col);
   }

   if (! ($value > 0)) {
      print STDERR "$0:setCellHeight:Invalid value $value\n";
      return 0;
   } else {
      $self->{"table:cellheight"}{"$row:$col"} = $value;
      return ($row, $col);
   }
}

#-------------------------------------------------------
# Subroutine:  	setCellBGColor(row_num, col_num, [colorname|colortrip]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setCellBGColor {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   (my $value = shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellBGColor:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellBGColor:Invalid table reference\n";
      return 0;
   }

   if (! $value) {
      #return to default alignment if none specified
      undef $self->{"table:cellbgcolor"}{"$row:$col"};
   }

   # BG colors are too hard to verify, let's assume user
   # knows what they are doing
   $self->{"table:cellbgcolor"}{"$row:$col"} = $value;
   return ($row, $col);
}

#-------------------------------------------------------
# Subroutine:  	setCellRowSpan(row_num, col_num, num_cells)
# Author:       Stacy Lacy	
# Date:		31 Jul 1997
#-------------------------------------------------------
sub setCellRowSpan {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   (my $value = shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellRowSpan:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellRowSpan:Invalid table reference\n";
      return 0;
   }

   if (! $value) {
      #return to default alignment if none specified
      undef $self->{"table:cellrowspan"}{"$row:$col"};
   }

   $self->{"table:cellrowspan"}{"$row:$col"} = $value;
   
   $self->_updateSpanGrid($row,$col);
   
   return ($row, $col);
}

#-------------------------------------------------------
# Subroutine:  	setCellColSpan(row_num, col_num, num_cells)
# Author:       Stacy Lacy	
# Date:		31 Jul 1997
#-------------------------------------------------------
sub setCellColSpan {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   (my $value = shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellColSpan:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellColSpan:Invalid table reference\n";
      return 0;
   }

   if (! $value) {
      #return to default alignment if none specified
      undef $self->{"table:cellcolspan"}{"$row:$col"};
   }

   $self->{"table:cellcolspan"}{"$row:$col"} = $value;

   $self->_updateSpanGrid($row,$col);
   
   return ($row, $col);

}

#-------------------------------------------------------
# Subroutine:  	setCellFormat(row_num, col_num, start_string, end_string) 
# Author:       Anthony Peacock
# Date:			21 Feb 2001
# Description:	Sets start and end HTML formatting strings for
#               the cell content
#-------------------------------------------------------
sub setCellFormat {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;
   (my $start_string = shift);
   (my $end_string = shift);

   if (($row > $self->{rows}) || ($row < 1) ) {
      print STDERR "$0:setCellFormat:Invalid table reference\n";
      return 0;
   }
   if (($col > $self->{cols}) || ($col < 1) ) {
      print STDERR "$0:setCellFormat:Invalid table reference\n";
      return 0;
   }

   if (! $start_string) {
      #return to default format if none specified
      undef $self->{"table:cellstartformat"}{"$row:$col"};
      undef $self->{"table:cellendformat"}{"$row:$col"};
   }
	else
	{
		# No checks will be made on the validity of these strings
		# User must take responsibility for results...
		$self->{"table:cellstartformat"}{"$row:$col"} = $start_string;
		$self->{"table:cellendformat"}{"$row:$col"} = $end_string;
   }
   return ($row, $col);
}

#-------------------------------------------------------
# Row config methods
# 
#-------------------------------------------------------

#-------------------------------------------------------
# Subroutine:  	addRow("cell 1 content" [, "cell 2 content",  ...]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub addRow {
   my $self = shift;

   # this sub should add a row, using @_ as contents
   my $count= @_;
   # if number of cells is greater than cols, let's assume
   # we want to add a column.
   $self->{cols} = $count if ($count >$self->{cols});
   $self->{rows}++;  # increment number of rows
   my $i;
   for ($i=1;$i <= $count;$i++) {
      # Store each value in cell on row
      $self->{table}{"$self->{rows}:$i"} = shift;
   }
   return $self->{rows};
   
}

#-------------------------------------------------------
# Subroutine:  	setRowAlign(row_num, [CENTER|RIGHT|LEFT]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setRowAlign {
   my $self = shift;
   (my $row = shift) || return 0;
   my $align = shift;
   # this sub should align a row given a row number;
   my $i;
   for ($i=1;$i <= $self->{cols};$i++) {
      $self->setCellAlign($row,$i, $align);
   }
}

#-------------------------------------------------------
# Subroutine:  	setRowVAlign(row_num, [CENTER|TOP|BOTTOM]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setRowVAlign {
   my $self = shift;
   (my $row = shift) || return 0;
   my $valign = shift;
   # this sub should align a row given a row number;
   my $i;
   for ($i=1;$i <= $self->{cols};$i++) {
      $self->setCellVAlign($row,$i, $valign);
   }
}

#-------------------------------------------------------
# Subroutine:  	setRowHead(row_num, [0|1]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setRowHead {
   my $self = shift;
   (my $row = shift) || return 0;
   my $value = shift || 1;

   # this sub should change the head flag of a row;
   my $i;
   for ($i=1;$i <= $self->{cols};$i++) {
      $self->setCellHead($row,$i, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setRowNoWrap(row_num, col_num, [0|1]) 
# Author:       Anthony Peacock
# Date:		22 Feb 2001
#-------------------------------------------------------
sub setRowNoWrap {
   my $self = shift;
   (my $row = shift) || return 0;
   my $value = shift;
   
   # this sub should change the wrap flag of a row;
   my $i;
   for ($i=1;$i <= $self->{cols};$i++) {
      $self->setCellNoWrap($row, $i, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setRowWidth(row_num, [pixels|percentoftable]) 
# Author:       Anthony Peacock
# Date:		22 Feb 2001
#-------------------------------------------------------
sub setRowWidth {
   my $self = shift;
   (my $row = shift) || return 0;
   my $value = shift;
   
   # this sub should change the cell width of a row;
   my $i;
   for ($i=1;$i <= $self->{cols};$i++) {
      $self->setCellWidth($row, $i, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setRowHeight(row_num, [pixels]) 
# Author:       Anthony Peacock
# Date:		22 Feb 2001
#-------------------------------------------------------
sub setRowHeight {
   my $self = shift;
   (my $row = shift) || return 0;
   my $value = shift;
   
   # this sub should change the cell height of a row;
   my $i;
   for ($i=1;$i <= $self->{cols};$i++) {
      $self->setCellHeight($row, $i, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setRowBGColor(row_num, [colorname|colortriplet]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setRowBGColor {
   my $self = shift;
   (my $row = shift) || return 0;
   my $value = shift;
   # this sub should set bgcolor for each
   # cell in a row given a row number;
   my $i;
   for ($i=1;$i <= $self->{cols};$i++) {
      $self->setCellBGColor($row,$i, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setRowFormat(row_num, start_string, end_string) 
# Author:       Anthony Peacock
# Date:			21 Feb 2001
#-------------------------------------------------------
sub setRowFormat {
   my $self = shift;
   (my $row = shift) || return 0;
   my ($start_string, $end_string) = @_;
   
   # this sub should set format strings for each
   # cell in a row given a row number;
   my $i;
   for ($i=1;$i <= $self->{cols};$i++) {
      $self->setCellFormat($row,$i, $start_string, $end_string);
   }
}

#-------------------------------------------------------
# Col config methods
# 
#-------------------------------------------------------

#-------------------------------------------------------
# Subroutine:  	addCol("cell 1 content" [, "cell 2 content",  ...]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub addCol {
   my $self = shift;
      
   # this sub should add a column, using @_ as contents
   my $count= @_;
   # if number of cells is greater than rows, let's assume
   # we want to add a row.
   $self->{rows} = $count if ($count >$self->{rows});
   $self->{cols}++;  # increment number of rows
   my $i;
   for ($i=1;$i <= $count;$i++) {
      # Store each value in cell on row
      $self->{table}{"$i:$self->{cols}"} = shift;
   }
   return $self->{cols};

}

#-------------------------------------------------------
# Subroutine:  	setColAlign(row_num, col_num, [CENTER|RIGHT|LEFT]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setColAlign {
   my $self = shift;
   (my $col = shift) || return 0;
   my $align = shift;
   # this sub should align a col given a col number;
   my $i;
   for ($i=1;$i <= $self->{rows};$i++) {
      $self->setCellAlign($i,$col, $align);
   }
}

#-------------------------------------------------------
# Subroutine:  	setColVAlign(col_num, [CENTER|TOP|BOTTOM])
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setColVAlign {
   my $self = shift;
   (my $col = shift) || return 0;
   my $valign = shift;
   # this sub should align a all rows given a column number;
   my $i;
   for ($i=1;$i <= $self->{rows};$i++) {
      $self->setCellVAlign($i,$col, $valign);
   }
}

#-------------------------------------------------------
# Subroutine:  	setColHead(col_num, [0|1]) 
# Author:       Jay Flaherty
# Date:		30 Mar 1998
#-------------------------------------------------------
sub setColHead {
   my $self = shift;
   (my $col = shift) || return 0;
   my $value = shift || 1;

   # this sub should set the head attribute of a col given a col number;
   my $i;
   for ($i=1;$i <= $self->{rows};$i++) {
      $self->setCellHead($i,$col, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setColNoWrap(row_num, col_num, [0|1]) 
# Author:       Stacy Lacy	
# Date:		30 Jul 1997
#-------------------------------------------------------
sub setColNoWrap {
   my $self = shift;
   (my $col = shift) || return 0;
   my $value = shift;
   # this sub should change the wrap flag of a column;
   my $i;
   for ($i=1;$i <= $self->{rows};$i++) {
      $self->setCellNoWrap($i,$col, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setColWidth(col_num, [pixels|percentoftable]) 
# Author:       Anthony Peacock
# Date:		22 Feb 2001
#-------------------------------------------------------
sub setColWidth {
   my $self = shift;
   (my $col = shift) || return 0;
   my $value = shift;
   
   # this sub should change the cell width of a col;
   my $i;
   for ($i=1;$i <= $self->{rows};$i++) {
      $self->setCellWidth($i, $col, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setColHeight(col_num, [pixels]) 
# Author:       Anthony Peacock
# Date:		22 Feb 2001
#-------------------------------------------------------
sub setColHeight {
   my $self = shift;
   (my $col = shift) || return 0;
   my $value = shift;
   
   # this sub should change the cell height of a col;
   my $i;
   for ($i=1;$i <= $self->{rows};$i++) {
      $self->setCellWidth($i, $col, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setColBGColor(col_num, [colorname|colortriplet]) 
# Author:       Jay Flaherty
# Date:		16 Nov 1998
#-------------------------------------------------------
sub setColBGColor{
   my $self = shift;
   (my $col = shift) || return 0;
   my $value = shift || 1;

   # this sub should set bgcolor for each
   # cell in a col given a col number;
   my $i;
   for ($i=1;$i <= $self->{rows};$i++) {
      $self->setCellBGColor($i,$col, $value);
   }
}

#-------------------------------------------------------
# Subroutine:  	setColFormat(row_num, start_string, end_string) 
# Author:       Anthony Peacock
# Date:			21 Feb 2001
#-------------------------------------------------------
sub setColFormat{
   my $self = shift;
   (my $col = shift) || return 0;
   my ($start_string, $end_string) = @_;
   
   # this sub should set format strings for each
   # cell in a col given a col number;
   my $i;
   for ($i=1;$i <= $self->{rows};$i++) {
      $self->setCellFormat($i,$col, $start_string, $end_string);
   }
}

#-------------------------------------------------------
#*******************************************************
#
# End of public methods
# 
# The following methods are internal to this package
#
#*******************************************************
#-------------------------------------------------------

#-------------------------------------------------------
# Subroutine:  	_updateSpanGrid(row_num, col_num)
# Author:       Stacy Lacy	
# Date:		31 Jul 1997
#-------------------------------------------------------
sub _updateSpanGrid {
   my $self = shift;
   (my $row = shift) || return 0;
   (my $col = shift) || return 0;

   my $colspan = $self->{"table:cellcolspan"}{"$row:$col"} || 0;
   my $rowspan = $self->{"table:cellrowspan"}{"$row:$col"} || 0;

	if ($self->{autogrow}) {
		$self->{cols} = $col + $colspan - 1 unless $self->{cols} > ($col + $colspan - 1 );
		$self->{rows} = $row + $rowspan - 1 unless $self->{rows} > ($row + $rowspan - 1 );
	}

   my ($i, $j);
   if ($colspan) {
      for ($j=$col+1;(($j <= $self->{cols}) && ($j <= ($col +$colspan -1))); $j++ ) {
            $self->{"table:cellspan"}{"$row:$j"} = "SPANNED";
      }
   }
   if ($rowspan) {
      for ($i=$row+1;(($i <= $self->{rows}) && ($i <= ($row +$rowspan -1))); $i++) {
            $self->{"table:cellspan"}{"$i:$col"} = "SPANNED";
      }
   }

   if ($colspan && $rowspan) {
      # Spanned Grid
      for ($i=$row+1;(($i <= $self->{rows}) && ($i <= ($row +$rowspan -1))); $i++) {
         for ($j=$col+1;(($j <= $self->{cols}) && ($j <= ($col +$colspan -1))); $j++ ) {
            $self->{"table:cellspan"}{"$i:$j"} = "SPANNED";
         }
      }
   }
}

#-------------------------------------------------------
# Subroutine:  	_getTableHashValues(tablehashname)
# Author:       Stacy Lacy	
# Date:		31 Jul 1997
#-------------------------------------------------------
sub _getTableHashValues {
   my $self = shift;
   (my $hashname = shift) || return 0;

   my ($i, $j, $retval);
   for ($i=1; $i <= ($self->{rows}); $i++) {
      for ($j=1; $j <= ($self->{cols}); $j++) {
         $retval.= "|$i:$j| " . ($self->{"$hashname"}{"$i:$j"}) . " ";
      }
      $retval.=" |<br>";
   }

   return $retval;
}

#-------------------------------------------------------
# Subroutine:  	_is_integer(string_value)
# Author:       Anthony Peacock	
# Date:		12 Jul 2000
# Description:	Checks the string value passed as a parameter
#               and returns true if it is an integer
#-------------------------------------------------------
sub _is_integer {
	my $str = shift;

	if ( $str =~ /^\s*\d+\s*$/ ) {
		return 1;
	} else {
		return;
	}
}

1;

__END__
