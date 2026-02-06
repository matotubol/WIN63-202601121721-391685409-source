package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.events.RoomSessionPetPackageEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_2486;
   
   public class PetPackageFurniWidgetHandler implements IRoomWidgetHandler, class_1829
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_315:int = -1;
      
      public function PetPackageFurniWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_PET_PACKAGE_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWOPPM_OPEN_PET_PACKAGE"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetOpenPetPackageMessage = null;
         var _loc3_:* = param1.type;
         if("RWOPPM_OPEN_PET_PACKAGE" === _loc3_)
         {
            _loc2_ = param1 as RoomWidgetOpenPetPackageMessage;
            if(_container != null && _container.roomSession != null)
            {
               _container.roomSession.sendOpenPetPackageMessage(_loc2_.objectId,_loc2_.name);
            }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSOPPE_OPEN_PET_PACKAGE_REQUESTED","RSOPPE_OPEN_PET_PACKAGE_RESULT"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc5_:RoomSessionPetPackageEvent = null;
         if(param1 == null)
         {
            return;
         }
         if(_container != null && _container.events != null && param1 != null)
         {
            switch(param1.type)
            {
               case "RSOPPE_OPEN_PET_PACKAGE_REQUESTED":
                  _loc5_ = param1 as RoomSessionPetPackageEvent;
                  var_315 = _loc5_.objectId;
                  var _loc4_:BitmapData = getPetImage(_loc5_.figureData);
                  var _loc6_:int = _loc5_.figureData?.typeId;
                  var _loc3_:RoomWidgetPetPackageUpdateEvent = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED",var_315,null,-1,null,0);
                  _container.events.dispatchEvent(null);
                  break;
               case "RSOPPE_OPEN_PET_PACKAGE_RESULT":
                  _loc5_ = param1 as RoomSessionPetPackageEvent;
                  var_315 = _loc5_.objectId;
                  var _loc2_:int = _loc5_.nameValidationStatus;
                  var _loc7_:String = _loc5_.nameValidationInfo;
                  _loc3_ = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_RESULT",var_315,null,0,null,-1);
                  _container.events.dispatchEvent(null);
            }
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
         var_315 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:RoomWidgetPetPackageUpdateEvent = new RoomWidgetPetPackageUpdateEvent("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE",var_315,param2,-1,null,-1);
         _container.events.dispatchEvent(_loc3_);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function getPetImage(param1:class_2486) : BitmapData
      {
         if(param1 != null)
         {
            var _loc2_:uint = parseInt(param1.color,16);
            var _loc3_:uint = 0;
            var _loc4_:class_2198 = _container.roomEngine.getPetImage(param1.typeId,param1.paletteId,0,new Vector3d(90),64,this,true,0);
            if(_loc4_ != null)
            {
               return null.data;
            }
         }
         return null;
      }
   }
}

