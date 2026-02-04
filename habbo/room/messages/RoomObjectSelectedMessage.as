package com.sulake.habbo.room.messages
{
   public class RoomObjectSelectedMessage extends RoomObjectUpdateStateMessage
   {
      
      private var _selected:Boolean;
      
      public function RoomObjectSelectedMessage(param1:Boolean)
      {
         super();
         _selected = param1;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
   }
}

