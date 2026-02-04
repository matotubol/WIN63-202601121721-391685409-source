package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class UserChooserWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1134:Boolean = false;
      
      public function UserChooserWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_USER_CHOOSER";
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
         _loc1_.push("RWRWM_USER_CHOOSER");
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
            case "RWRWM_USER_CHOOSER":
               handleUserChooserRequest();
               break;
            case "RWROM_SELECT_OBJECT":
               var _loc2_:RoomWidgetRoomObjectMessage = param1 as RoomWidgetRoomObjectMessage;
               return null;
         }
         return null;
      }
      
      private function compareItems(param1:ChooserItem, param2:ChooserItem) : int
      {
         if(param1 == null || param2 == null || param1.name == param2.name || param1.name.length == 0 || param2.name.length == 0)
         {
            return 1;
         }
         var _loc3_:Array = new Array(param1.name.toUpperCase(),param2.name.toUpperCase()).sort();
         if(_loc3_.indexOf(param1.name.toUpperCase()) == 0)
         {
            return -1;
         }
         return 1;
      }
      
      private function handleUserChooserRequest() : void
      {
         var _loc2_:IRoomObject = null;
         var _loc4_:int = 0;
         var _loc1_:class_2146 = null;
         if(_container == null || _container.roomSession == null || _container.roomEngine == null)
         {
            return;
         }
         if(_container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc6_:int = _container.roomSession.roomId;
         var _loc5_:Array = [];
         var _loc3_:int = _container.roomEngine.getRoomObjectCount(_loc6_,100);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _container.roomEngine.getRoomObjectWithIndex(_loc6_,_loc4_,100);
            _loc1_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
            if(_loc1_ != null)
            {
               _loc5_.push(new ChooserItem(_loc1_.roomObjectId,100,_loc1_.name,null,_loc1_.type));
            }
            _loc4_++;
         }
         _loc5_.sort(compareItems);
         _container.events.dispatchEvent(new RoomWidgetChooserContentEvent("RWCCE_USER_CHOOSER_CONTENT",_loc5_));
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

