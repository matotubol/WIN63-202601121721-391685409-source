package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.room.object.IRoomObjectModelController;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class class_1883 extends class_1738
   {
      
      public function class_1883()
      {
         super();
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.action;
         if(_loc2_.length() != 0)
         {
            object.getModelController().setString("furniture_internal_link",_loc2_.@link);
         }
      }
      
      public function setAnimationState(param1:int) : void
      {
         if(object == null)
         {
            return;
         }
         var _loc2_:IRoomObjectModelController = object.getModelController();
         if(_loc2_ != null)
         {
            _loc2_.setNumber("furniture_automatic_state_index",param1,false);
         }
      }
      
      override public function getEventTypes() : Array
      {
         return getAllEventTypes(super.getEventTypes(),["ROWRE_ROOM_LINK"]);
      }
      
      override public function useObject() : void
      {
         setAnimationState(1);
         var _loc1_:Timer = new Timer(2500);
         _loc1_.addEventListener("timer",onFakeAnimationOver);
         _loc1_.start();
         if(eventDispatcher != null && object != null)
         {
            eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_ROOM_LINK",object));
         }
      }
      
      private function onFakeAnimationOver(param1:TimerEvent) : void
      {
         setAnimationState(0);
      }
   }
}

