package com.sulake.habbo.ui.widget.chooser
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.class_38;
   
   public class ChooserWidgetBase extends RoomWidgetBase
   {
      
      public function ChooserWidgetBase(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null, param4:class_27 = null)
      {
         super(param1,param2,param3,param4);
      }
      
      public function choose(param1:int, param2:int) : void
      {
         var _loc3_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage("RWROM_SELECT_OBJECT",param1,param2);
         messageListener.processWidgetMessage(_loc3_);
      }
   }
}

