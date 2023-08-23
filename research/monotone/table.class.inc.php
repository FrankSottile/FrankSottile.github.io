<?php
  class html_cell {
     var $align, $valign, $width, $height, $bgcolor, $background, $rowspan, $colspan, $js;
     var $cell_content, $classname;

     function show_cell() {
        echo "<td ";
        if ($this->align)      {echo "align=".$this->align." ";}
        if ($this->valign)     {echo "valign=".$this->valign." ";}
        if ($this->width)      {echo "width=\"".$this->width."\" ";}
        if ($this->height)     {echo "height=\"".$this->height."\" ";}
        if ($this->bgcolor)    {echo "bgcolor=\"".$this->bgcolor."\" ";}
        if ($this->background) {echo "background=\"".$this->background."\" ";}
        if ($this->rowspan)    {echo "rowspan=\"".$this->rowspan."\" ";}
        if ($this->colspan)    {echo "colspan=\"".$this->colspan."\" ";}
        if ($this->classname)  {echo "class=\"".$this->classname."\" ";}
        if ($this->js)         {echo $this->js;}
        echo ">".$this->cell_content."</td>\n";
     }
  }

  class html_row {
     var $align, $valign, $bgcolor, $background, $js;
     var $cell;

     function new_cell($cell_content,$parameter) {
        $this->cell[] = new html_cell;
        $newcell = new html_cell;
        $newcell->cell_content = $cell_content;
        $newcell->align = $parameter['align'];
        $newcell->valign = $parameter['valign'];
        $newcell->width = $parameter['width'];
        $newcell->height = $parameter['height'];
        $newcell->bgcolor = $parameter['bgcolor'];
        $newcell->background = $parameter['background'];
        $newcell->rowspan = $parameter['rowspan'];
        $newcell->colspan = $parameter['colspan'];
        $newcell->classname = $parameter['classname'];
        $newcell->js = $parameter['js'];
        $this->cell[sizeof($this->cell)-1] = $newcell;
     }

     function show_row() {
        echo "<tr ";
        if ($this->align)      {echo "align=".$this->align." ";}
        if ($this->valign)     {echo "valign=".$this->valign." ";}
        if ($this->bgcolor)    {echo "bgcolor=\"".$this->bgcolor."\" ";}
        if ($this->background) {echo "background=\"".$this->background."\" ";}
        if ($this->js)         {echo $this->js;}
        echo ">";
        for ($i=0;$i<sizeof($this->cell);$i++) {
           $showcell = $this->cell[$i];
           $showcell->show_cell();
        }
        echo "</tr>\n";
     }
  }

  class html_table {
     var $border, $cellspacing, $cellpadding, $cols, $width, $height, $bgcolor, $background, $rowdefault, $celldefault;
     var $row, $alternatecolor, $coloralternation;
     var $center;

     function html_table() {
        if (func_num_args()) $parameter = func_get_arg(0);
        if (isset($parameter['center'])) {$this->center = $parameter['center'];} else {$this->center = 0;}
        if (isset($parameter['border'])) {$this->border = $parameter['border'];} else {$this->border = 0;}
        if (isset($parameter['cellspacing'])) {$this->cellspacing = $parameter['cellspacing'];} else {$this->cellspacing = 0;}
        if (isset($parameter['cellpadding'])) {$this->cellpadding = $parameter['cellpadding'];} else {$this->cellpadding = 0;}
        if (isset($parameter['cols'])) {$this->cols = $parameter['cols'];} else {$this->cols = 0;}
        if (isset($parameter['width'])) {$this->width = $parameter['width'];} else {$this->width = '100%';}
        if (isset($parameter['height'])) {$this->height = $parameter['height'];} else {$this->height = 0;}
        if (isset($parameter['bgcolor'])) {$this->bgcolor = $parameter['bgcolor'];} else {$this->bgcolor = 0;}
        if (isset($parameter['background'])) {$this->background = $parameter['background'];} else {$this->background = 0;}

        $this->rowdefault['align'] = 'left';
        $this->rowdefault['valign'] = 'middle';
        $this->rowdefault['bgcolor'] = 0;
        $this->rowdefault['background'] = 0;
        $this->rowdefault['js'] = 0;

        $this->celldefault['align'] = 'left';
        $this->celldefault['valign'] = 'middle';
        $this->celldefault['width'] = 0;
        $this->celldefault['height'] = 0;
        $this->celldefault['bgcolor'] = 0;
        $this->celldefault['background'] = 0;
        $this->celldefault['rowspan'] = 0;
        $this->celldefault['colspan'] = 0;
        $this->celldefault['classname'] = 0;
        $this->celldefault['js'] = 0;

        $this->coloralternation = 0;
     }

     function new_row() {
        if (func_num_args()) $parameter = func_get_arg(0);
        if (isset($this->alternatecolor)) {
           $parameter['bgcolor'] = $this->alternatecolor[$this->coloralternation];
           $this->coloralternation = ($this->coloralternation) ? (0) : (1);
        }
        $this->row[] = new html_row;
        $newrow = new html_row;
        if (isset($parameter['align'])) {$newrow->align = $parameter['align'];} else {$newrow->align = $this->rowdefault['align'];}
        if (isset($parameter['valign'])) {$newrow->valign = $parameter['valign'];} else {$newrow->valign = $this->rowdefault['valign'];}
        if (isset($parameter['bgcolor'])) {$newrow->bgcolor = $parameter['bgcolor'];} else {$newrow->bgcolor = $this->rowdefault['bgcolor'];}
        if (isset($parameter['background'])) {$newrow->background = $parameter['background'];} else {$newrow->background = $this->rowdefault['background'];}
        if (isset($parameter['js'])) {$newrow->js = $parameter['js'];} else {$newrow->js = $this->rowdefault['js'];}
        $this->row[sizeof($this->row)-1] = $newrow;
     }

     function set_row_default($parameter) {
        if (isset($parameter['align'])) $this->rowdefault['align'] = $parameter['align'];
        if (isset($parameter['valign'])) $this->rowdefault['valign'] = $parameter['valign'];
        if (isset($parameter['bgcolor'])) $this->rowdefault['bgcolor'] = $parameter['bgcolor'];
        if (isset($parameter['background'])) $this->rowdefault['background'] = $parameter['background'];
        if (isset($parameter['js'])) $this->rowdefault['js'] = $parameter['js'];
     }

     function alternate_color($color1,$color2) {
        $this->alternatecolor[] = $color1;
        $this->alternatecolor[] = $color2;
     }

     function new_cell($cell_content) {
        $parameter = $this->celldefault;
        if (func_num_args() > 1) {
            $parameter2 = func_get_arg(1);
            if (isset($parameter2['align'])) $parameter['align'] = $parameter2['align'];
            if (isset($parameter2['valign'])) $parameter['valign'] = $parameter2['valign'];
            if (isset($parameter2['width'])) $parameter['width'] = $parameter2['width'];
            if (isset($parameter2['height'])) $parameter['height'] = $parameter2['height'];
            if (isset($parameter2['bgcolor'])) $parameter['bgcolor'] = $parameter2['bgcolor'];
            if (isset($parameter2['background'])) $parameter['background'] = $parameter2['background'];
            if (isset($parameter2['rowspan'])) $parameter['rowspan'] = $parameter2['rowspan'];
            if (isset($parameter2['colspan'])) $parameter['colspan'] = $parameter2['colspan'];
            if (isset($parameter2['classname'])) $parameter['classname'] = $parameter2['classname'];
            if (isset($parameter2['js'])) $parameter['js'] = $parameter2['js'];
        }
        $actualrow = new html_row;
        $actualrow = $this->row[sizeof($this->row)-1];
        $actualrow->new_cell($cell_content,$parameter);
        $this->row[sizeof($this->row)-1] = $actualrow;
     }

     function set_cell_default($parameter) {
        if (isset($parameter['align'])) $this->celldefault['align'] = $parameter['align'];
        if (isset($parameter['valign'])) $this->celldefault['valign'] = $parameter['valign'];
        if (isset($parameter['width'])) $this->celldefault['width'] = $parameter['width'];
        if (isset($parameter['height'])) $this->celldefault['height'] = $parameter['height'];
        if (isset($parameter['bgcolor'])) $this->celldefault['bgcolor'] = $parameter['bgcolor'];
        if (isset($parameter['background'])) $this->celldefault['background'] = $parameter['background'];
        if (isset($parameter['rowspan'])) $this->celldefault['rowspan'] = $parameter['rowspan'];
        if (isset($parameter['colspan'])) $this->celldefault['colspan'] = $parameter['colspan'];
        if (isset($parameter['classname'])) $this->celldefault['classname'] = $parameter['classname'];
        if (isset($parameter['js'])) $this->celldefault['js'] = $parameter['js'];
     }

     function show_table() {
        if ($this->center)      {echo "<center>\n";}
        echo "<table ";
        if ($this->border)      {echo "border=\"".$this->border."\" ";}
        if ($this->cellspacing) {echo "cellspacing=\"".$this->cellspacing."\" ";}
        if ($this->cellpadding) {echo "cellpadding=\"".$this->cellpadding."\" ";}
        if ($this->cellspacing == 0) {echo "cellspacing=\"".$this->cellspacing."\" ";}
        if ($this->cellpadding == 0) {echo "cellpadding=\"".$this->cellpadding."\" ";}
        if ($this->cols)        {echo "cols=\"".$this->cols."\" ";}
        if ($this->width)       {echo "width=\"".$this->width."\" ";}
        if ($this->height)      {echo "height=\"".$this->height."\" ";}
        if ($this->bgcolor)     {echo "bgcolor=\"".$this->bgcolor."\" ";}
        if ($this->background)  {echo "background=\"".$this->background."\" ";}
        echo ">\n";
        for ($i=0;$i<sizeof($this->row);$i++) {
           $showrow = $this->row[$i];
           $showrow->show_row();
        }
        echo "</table>\n";
        if ($this->center)      {echo "</center>\n";}
     }
  }

?>