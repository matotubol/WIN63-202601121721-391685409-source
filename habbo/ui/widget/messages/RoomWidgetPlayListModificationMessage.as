package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPlayListModificationMessage extends RoomWidgetMessage
   {
      
      public static const ADD_TO_PLAYLIST:String = "RWPLAM_ADD_TO_PLAYLIST";
      
      public static const REMOVE_FROM_PLAYLIST:String = "RWPLAM_REMOVE_FROM_PLAYLIST";
      
      private var var_4914:int;
      
      private var _slotNumber:int;
      
      public function RoomWidgetPlayListModificationMessage(param1:String, param2:int = -1, param3:int = -1)
      {
         super(param1);
         _slotNumber = param2;
         var_4914 = param3;
      }
      
      public function get diskId() : int
      {
         return var_4914;
      }
      
      public function get slotNumber() : int
      {
         return _slotNumber;
      }
   }
}

