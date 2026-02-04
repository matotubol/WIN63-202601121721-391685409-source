package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAchievementResolutionTrophyDataUpdateEvent;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   
   public class AchievementResolutionTrophyFurniWidget extends RoomWidgetBase implements ITrophyFurniWidget
   {
      
      private var _name:String;
      
      private var var_1573:String;
      
      private var var_986:String;
      
      private var _color:int;
      
      private var var_637:class_16;
      
      private var var_18:ITrophyView;
      
      private var var_3530:int;
      
      public function AchievementResolutionTrophyFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_16)
      {
         super(param1,param2,param3,param4);
         var_637 = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get date() : String
      {
         return var_1573;
      }
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function get configuration() : class_16
      {
         return var_637;
      }
      
      override public function dispose() : void
      {
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         var_637 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWARTDUE_TROPHY_DATA",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWARTDUE_TROPHY_DATA",onObjectUpdate);
      }
      
      private function onObjectUpdate(param1:RoomWidgetAchievementResolutionTrophyDataUpdateEvent) : void
      {
         _name = param1.name;
         var_1573 = param1.date;
         var_986 = param1.message;
         _color = param1.color - 1;
         var_3530 = param1.viewType;
         if(_color < 0 || _color > 2)
         {
            _color = 0;
         }
         updateInterface();
      }
      
      private function updateInterface() : void
      {
         if(var_18 != null)
         {
            var_18.dispose();
         }
         var _loc1_:int = var_3530;
         var_18 = new TrophyView(this);
         var_18.showInterface();
      }
   }
}

