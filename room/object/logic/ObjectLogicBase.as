package com.sulake.room.object.logic
{
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.IEventDispatcher;
   
   public class ObjectLogicBase implements IRoomObjectEventHandler
   {
      
      private var name_1:IEventDispatcher;
      
      private var var_612:IRoomObjectController;
      
      public function ObjectLogicBase()
      {
         super();
      }
      
      public function get eventDispatcher() : IEventDispatcher
      {
         return name_1;
      }
      
      public function set eventDispatcher(param1:IEventDispatcher) : void
      {
         name_1 = param1;
      }
      
      public function getEventTypes() : Array
      {
         return [];
      }
      
      protected function getAllEventTypes(param1:Array, param2:Array) : Array
      {
         var _loc3_:Array = param1.concat();
         for each(var _loc4_ in param2)
         {
            if(_loc3_.indexOf(_loc4_) < 0)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         var_612 = null;
      }
      
      public function set object(param1:IRoomObjectController) : void
      {
         if(var_612 == param1)
         {
            return;
         }
         if(var_612 != null)
         {
            var_612.setEventHandler(null);
         }
         if(param1 == null)
         {
            dispose();
            var_612 = null;
         }
         else
         {
            var_612 = param1;
            var_612.setEventHandler(this);
         }
      }
      
      public function get object() : IRoomObjectController
      {
         return var_612;
      }
      
      public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
      }
      
      public function initialize(param1:XML) : void
      {
      }
      
      public function update(param1:int) : void
      {
      }
      
      public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 != null)
         {
            if(var_612 != null)
            {
               var_612.setLocation(param1.loc);
               var_612.setDirection(param1.dir);
            }
         }
      }
      
      public function useObject() : void
      {
      }
      
      public function tearDown() : void
      {
      }
      
      public function get widget() : String
      {
         return null;
      }
      
      public function get contextMenu() : String
      {
         return null;
      }
   }
}

