package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAchievementResolutionTrophyDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class class_2736 implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function class_2736()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING","RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED","RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc5_:RoomWidgetFurniToWidgetMessage = null;
         var _loc4_:IRoomObject = null;
         var _loc12_:IRoomObjectModel = null;
         var _loc6_:StringArrayStuffData = null;
         if(disposed || param1 == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case "RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING":
            case "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING":
               _loc5_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc4_ = _container.roomEngine.getRoomObject(_loc5_.roomId,_loc5_.id,_loc5_.category);
               if(_loc4_ != null)
               {
                  _loc12_ = _loc4_.getModel();
                  if(_loc12_ != null)
                  {
                     _loc6_ = new StringArrayStuffData();
                     _loc6_.initializeFromRoomObjectModel(_loc12_);
                     var _loc7_:String = _container.localization.getBadgeName(_loc6_.getValue(1));
                     var _loc3_:String = "\r\n" + _container.localization.getBadgeDesc(_loc6_.getValue(1));
                     var _loc11_:String = _loc6_.getValue(2);
                     var _loc2_:String = _loc6_.getValue(3);
                     var _loc8_:String = param1.type == "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING" ? "resolution.engraving.text" : "badge.display.engraving.text";
                     var _loc9_:* = _container.localization.getLocalizationWithParams(null,"%badgename%","badgename",null,"badgedesc",null);
                     if(_loc9_ == null)
                     {
                        _loc9_ = null;
                     }
                     var _loc10_:RoomWidgetAchievementResolutionTrophyDataUpdateEvent = new RoomWidgetAchievementResolutionTrophyDataUpdateEvent("RWARTDUE_TROPHY_DATA",0,null,null,null,0);
                     _container.events.dispatchEvent(null);
                  }
               }
               break;
            case "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED":
               _container.windowManager.simpleAlert("${resolution.failed.title}","${resolution.failed.subtitle}","${resolution.failed.text}",null,null,null,"help_error_state");
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}

