package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectSelectedMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class class_1909 extends class_1908
   {
      
      public static const STATE_RESOLUTION_NOT_STARTED:int = 0;
      
      public static const STATE_RESOLUTION_IN_PROGRESS:int = 1;
      
      public static const STATE_RESOLUTION_ACHIEVED:int = 2;
      
      public static const STATE_RESOLUTION_FAILED:int = 3;
      
      private static const ACH_NOT_SET:String = "ACH_0";
      
      private static const BADGE_VISIBLE_IN_STATE:Number = 2;
      
      public function class_1909()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_ACHIEVEMENT_RESOLUTION_OPEN","ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING","ROWRE_ACHIEVEMENT_RESOLUTION_FAILED","ROGBE_LOAD_BADGE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc4_:RoomObjectEvent = null;
         super.processUpdateMessage(param1);
         var _loc3_:RoomObjectGroupBadgeUpdateMessage = param1 as RoomObjectGroupBadgeUpdateMessage;
         if(_loc3_ != null)
         {
            if(_loc3_.assetName != "loading_icon")
            {
               object.getModelController().setNumber("furniture_badge_visible_in_state",2);
            }
         }
         var _loc2_:RoomObjectSelectedMessage = param1 as RoomObjectSelectedMessage;
         if(_loc2_)
         {
            if(eventDispatcher != null && object != null)
            {
               if(!_loc2_.selected)
               {
                  _loc4_ = new RoomObjectWidgetRequestEvent("ROWRE_CLOSE_FURNI_CONTEXT_MENU",object);
                  eventDispatcher.dispatchEvent(_loc4_);
               }
            }
         }
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = null;
            switch(int(object.getState(0)))
            {
               case 0:
               case 1:
                  _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_ACHIEVEMENT_RESOLUTION_OPEN",object);
                  break;
               case 2:
                  _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING",object);
                  break;
               case 3:
                  _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_ACHIEVEMENT_RESOLUTION_FAILED",object);
            }
            if(_loc1_)
            {
               eventDispatcher.dispatchEvent(_loc1_);
            }
         }
      }
      
      override protected function updateBadge(param1:String) : void
      {
         if(param1 != "ACH_0")
         {
            super.updateBadge(param1);
         }
      }
   }
}

