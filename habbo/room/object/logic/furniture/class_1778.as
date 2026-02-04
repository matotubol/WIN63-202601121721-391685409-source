package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class class_1778 extends class_1738
   {
      
      private var var_2519:Boolean = false;
      
      private var var_3494:int = 0;
      
      public function class_1778()
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
            if(_loc2_.@startState == "1")
            {
               var_2519 = true;
            }
         }
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(!var_2519)
         {
            return;
         }
         var_3494 = var_3494 + 1;
         if(var_2519 && var_3494 > 20)
         {
            setAnimationState(1);
            var_2519 = false;
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
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == "doubleClick")
         {
            setAnimationState(0);
         }
         super.mouseEvent(param1,param2);
      }
      
      override public function getEventTypes() : Array
      {
         return getAllEventTypes(super.getEventTypes(),["ROWRE_INTERNAL_LINK"]);
      }
      
      override public function useObject() : void
      {
         if(eventDispatcher != null && object != null)
         {
            eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_INTERNAL_LINK",object));
         }
      }
   }
}

