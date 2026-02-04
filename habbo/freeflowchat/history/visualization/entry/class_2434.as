package com.sulake.habbo.freeflowchat.history.visualization.entry
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public interface class_2434
   {
      
      function get bitmap() : BitmapData;
      
      function get overlap() : Rectangle;
      
      function get userId() : int;
      
      function get roomId() : int;
      
      function get canIgnore() : Boolean;
      
      function get userName() : String;
   }
}

