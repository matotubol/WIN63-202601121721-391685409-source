package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.mannequin.MannequinWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class MannequinWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var var_16:MannequinWidget;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      public function MannequinWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function dispose() : void
      {
         if(!var_1134)
         {
            container = null;
            var_1134 = true;
         }
      }
      
      public function get type() : String
      {
         return "RWE_MANNEQUIN";
      }
      
      public function set widget(param1:MannequinWidget) : void
      {
         var_16 = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RETWE_REQUEST_MANNEQUIN");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomEngineObjectEvent = null;
         var _loc3_:IRoomObject = null;
         var _loc5_:IRoomObjectModel = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:* = param1.type;
         if("RETWE_REQUEST_MANNEQUIN" === _loc8_)
         {
            _loc2_ = param1 as RoomEngineObjectEvent;
            _loc3_ = _container.roomEngine.getRoomObject(_loc2_.roomId,_loc2_.objectId,_loc2_.category);
            _loc5_ = _loc3_.getModel();
            _loc4_ = _loc5_.getString("furniture_mannequin_figure");
            _loc6_ = _loc5_.getString("furniture_mannequin_gender");
            _loc7_ = _loc5_.getString("furniture_mannequin_name");
            if(_loc4_ != null && _loc6_ != null)
            {
               var_16.open(_loc3_.getId(),_loc4_,_loc6_,_loc7_);
            }
         }
      }
      
      public function update() : void
      {
      }
   }
}

