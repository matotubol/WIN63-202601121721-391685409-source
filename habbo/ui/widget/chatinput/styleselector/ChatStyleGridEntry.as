package com.sulake.habbo.ui.widget.chatinput.styleselector
{
   import flash.display.BitmapData;
   
   public class ChatStyleGridEntry
   {
      
      private var var_197:int;
      
      private var _bitmap:BitmapData;
      
      public function ChatStyleGridEntry(param1:int, param2:BitmapData)
      {
         super();
         var_197 = param1;
         _bitmap = param2;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmap;
      }
   }
}

