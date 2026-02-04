package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class class_1975 extends class_1738
   {
      
      private static const SHOW_WIDGET_IN_STATE:int = 1;
      
      private var var_61:int = -1;
      
      public function class_1975()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         return ["ROWRE_HIGH_SCORE_DISPLAY","ROWRE_HIDE_HIGH_SCORE_DISPLAY"];
      }
      
      override public function tearDown() : void
      {
         if(object.getModelController().getNumber("furniture_real_room_object") == 1)
         {
            eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_HIDE_HIGH_SCORE_DISPLAY",object));
         }
         super.tearDown();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         if(object.getModelController().getNumber("furniture_real_room_object") != 1)
         {
            return;
         }
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null)
         {
            if(_loc2_.state == 1)
            {
               eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_HIGH_SCORE_DISPLAY",object));
            }
            else
            {
               eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_HIDE_HIGH_SCORE_DISPLAY",object));
            }
            var_61 = _loc2_.state;
            return;
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc3_:* = param1.type;
         if("doubleClick" !== _loc3_)
         {
            super.mouseEvent(param1,param2);
         }
         else
         {
            useObject();
         }
      }
   }
}

