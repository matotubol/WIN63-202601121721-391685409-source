package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class FurniChooserWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1134:Boolean = false;
      
      public function FurniChooserWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_CHOOSER";
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWRWM_FURNI_CHOOSER");
         _loc1_.push("RWRWM_FURNI_CHOOSER_ADD");
         _loc1_.push("RWROM_SELECT_OBJECT");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         if(param1 == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case "RWRWM_FURNI_CHOOSER":
               handleFurniChooserRequest();
               break;
            case "RWRWM_FURNI_CHOOSER_ADD":
               var _loc2_:RoomWidgetRequestWidgetMessage = param1 as RoomWidgetRequestWidgetMessage;
               var _loc4_:IRoomObject = _container.roomEngine.getRoomObject(_container.roomEngine.activeRoomId,null.id,null.category);
               var _loc5_:ChooserItem = getChooserItemFor(null,null.category);
               if(_loc5_ != null)
               {
                  _container.events.dispatchEvent(new RoomWidgetChooserContentEvent("RWCCE_FURNI_CHOOSER_CONTENT_ADD",[null],_container.sessionDataManager.isAnyRoomController));
               }
               break;
            case "RWROM_SELECT_OBJECT":
               var _loc3_:RoomWidgetRoomObjectMessage = param1 as RoomWidgetRoomObjectMessage;
               return null;
         }
         return null;
      }
      
      public function getChooserItemFor(param1:IRoomObject, param2:int) : ChooserItem
      {
         var _loc6_:int = 0;
         var _loc5_:class_1800 = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc8_:int = 0;
         if(param1 != null)
         {
            if(param2 == 10)
            {
               _loc6_ = param1.getModel().getNumber("furniture_type_id");
               _loc5_ = _container.sessionDataManager.getFloorItemData(_loc6_);
               if(_loc5_ != null)
               {
                  _loc7_ = _loc5_.localizedName;
               }
               else
               {
                  _loc7_ = param1.getType();
               }
               _loc3_ = param1.getModel().getString("furniture_owner_name");
               return new ChooserItem(param1.getId(),10,_loc7_,_loc3_);
            }
            if(param2 == 20)
            {
               _loc4_ = param1.getType();
               if(_loc4_.indexOf("poster") == 0)
               {
                  _loc8_ = int(_loc4_.replace("poster",""));
                  _loc7_ = _container.localization.getLocalization("poster_" + _loc8_ + "_name","poster_" + _loc8_ + "_name");
               }
               else
               {
                  _loc6_ = param1.getModel().getNumber("furniture_type_id");
                  _loc5_ = _container.sessionDataManager.getWallItemData(_loc6_);
                  if(_loc5_ != null && _loc5_.localizedName.length > 0)
                  {
                     _loc7_ = _loc5_.localizedName;
                  }
                  else
                  {
                     _loc7_ = _loc4_;
                  }
               }
               _loc3_ = param1.getModel().getString("furniture_owner_name");
               return new ChooserItem(param1.getId(),20,_loc7_,_loc3_);
            }
         }
         return null;
      }
      
      private function handleFurniChooserRequest() : void
      {
         var _loc4_:int = 0;
         var _loc1_:IRoomObject = null;
         var _loc5_:ChooserItem = null;
         if(_container == null || _container.roomSession == null || _container.roomEngine == null)
         {
            return;
         }
         if(_container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc7_:int = _container.roomSession.roomId;
         var _loc6_:Array = [];
         var _loc3_:int = _container.roomEngine.getRoomObjectCount(_loc7_,10);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _container.roomEngine.getRoomObjectWithIndex(_loc7_,_loc4_,10);
            _loc5_ = getChooserItemFor(_loc1_,10);
            if(_loc5_ != null)
            {
               _loc6_.push(_loc5_);
            }
            _loc4_++;
         }
         _loc3_ = _container.roomEngine.getRoomObjectCount(_loc7_,20);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _container.roomEngine.getRoomObjectWithIndex(_loc7_,_loc4_,20);
            _loc5_ = getChooserItemFor(_loc1_,20);
            if(_loc5_ != null)
            {
               _loc6_.push(_loc5_);
            }
            _loc4_++;
         }
         _container.events.dispatchEvent(new RoomWidgetChooserContentEvent("RWCCE_FURNI_CHOOSER_CONTENT",_loc6_,_container.sessionDataManager.isAnyRoomController));
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}

