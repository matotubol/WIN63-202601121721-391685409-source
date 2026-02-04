package com.sulake.habbo.ui.widget.furniture.friendfurni
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.class_2664;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   
   public class FriendFurniEngravingWidget extends RoomWidgetBase
   {
      
      private var _stuffId:int = -1;
      
      private var var_991:FriendFurniEngravingView;
      
      public function FriendFurniEngravingWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27)
      {
         super(param1,param2,param3,param4);
         engravingWidgetHandler.widget = this;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get engravingWidgetHandler() : class_2664
      {
         return var_41 as class_2664;
      }
      
      public function open(param1:int, param2:int, param3:StringArrayStuffData) : void
      {
         close(_stuffId);
         _stuffId = param1;
         switch(param2)
         {
            case 0:
               var_991 = new LoveLockEngravingView(this,param3);
               break;
            case 3:
               var_991 = new WildWestEngravingView(this,param3);
               break;
            case 4:
               var_991 = new HabboweenEngravingView(this,param3);
         }
         var_991.open();
      }
      
      public function close(param1:int) : void
      {
         if(param1 == _stuffId && var_991)
         {
            var_991.dispose();
            var_991 = null;
            _stuffId = -1;
         }
      }
   }
}

