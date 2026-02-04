package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureCreditWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FurnitureCreditWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_CREDIT_WIDGET";
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
         return ["RWFWM_MESSAGE_REQUEST_CREDITFURNI","RWFCRM_REDEEM"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc3_:RoomWidgetFurniToWidgetMessage = null;
         var _loc2_:IRoomObject = null;
         var _loc8_:IRoomObjectModel = null;
         var _loc7_:Number = NaN;
         var _loc4_:String = null;
         var _loc9_:* = false;
         var _loc5_:RoomWidgetCreditFurniUpdateEvent = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_CREDITFURNI":
               _loc3_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc2_ = _container.roomEngine.getRoomObject(_loc3_.roomId,_loc3_.id,_loc3_.category);
               if(_loc2_ != null && _container.isOwnerOfFurniture(_loc2_))
               {
                  _loc8_ = _loc2_.getModel();
                  if(_loc8_ != null)
                  {
                     _loc7_ = _loc8_.getNumber("furniture_credit_value");
                     _loc4_ = _loc8_.getString("furniture_nft_credit");
                     _loc9_ = _loc4_ == "true";
                     if(_loc9_ && !_container.config.getBoolean("nft.credit.converting.enabled"))
                     {
                        return null;
                     }
                     _loc5_ = new RoomWidgetCreditFurniUpdateEvent("RWCFUE_CREDIT_FURNI_UPDATE",_loc3_.id,_loc7_,_loc9_);
                     _container.events.dispatchEvent(_loc5_);
                  }
               }
               break;
            case "RWFCRM_REDEEM":
               var _loc6_:RoomWidgetCreditFurniRedeemMessage = param1 as RoomWidgetCreditFurniRedeemMessage;
               if(_container != null && _container.roomSession != null)
               {
                  _container.roomSession.sendCreditFurniRedeemMessage(null.objectId);
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
         if(_container != null && _container.events != null && null != null)
         {
            _container.events.dispatchEvent(null);
         }
      }
      
      public function update() : void
      {
      }
   }
}

