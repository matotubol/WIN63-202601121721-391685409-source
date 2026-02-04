package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.avatar.class_2071;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureClothingChangeWidgetHandler implements IRoomWidgetHandler, class_2071
   {
      
      private static const DEFAULT_BOY_CLOTHES:String = "hd-99999-99999.lg-270-62";
      
      private static const DEFAULT_GIRL_CLOTHES:String = "hd-99999-99999.ch-630-62.lg-695-62";
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_315:int = -1;
      
      public function FurnitureClothingChangeWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_CLOTHING_CHANGE";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         if(_container && _container.avatarEditor)
         {
            _container.avatarEditor.close(1);
         }
         var_1134 = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE","RWCCM_REQUEST_EDITOR","RWCM_OPEN_AVATAR_EDITOR"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc6_:RoomWidgetFurniToWidgetMessage = null;
         var _loc3_:Boolean = false;
         var _loc4_:IRoomObject = null;
         var _loc9_:IRoomObjectModel = null;
         var _loc2_:RoomWidgetClothingChangeUpdateEvent = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE":
               _loc6_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc4_ = _container.roomEngine.getRoomObject(_loc6_.roomId,_loc6_.id,_loc6_.category);
               if(_loc4_ != null)
               {
                  _loc9_ = _loc4_.getModel();
                  if(_loc9_ != null)
                  {
                     _loc3_ = _container.roomSession.isRoomOwner || _container.sessionDataManager.isAnyRoomController || _container.roomSession.roomControllerLevel >= 1;
                     if(_loc3_)
                     {
                        _loc2_ = new RoomWidgetClothingChangeUpdateEvent("RWCCUE_SHOW_GENDER_SELECTION",_loc6_.id,_loc6_.category,_loc6_.roomId);
                        _container.events.dispatchEvent(_loc2_);
                     }
                  }
               }
               break;
            case "RWCCM_REQUEST_EDITOR":
               var _loc7_:RoomWidgetClothingChangeMessage = param1 as RoomWidgetClothingChangeMessage;
               _loc4_ = _container.roomEngine.getRoomObject(null.roomId,null.objectId,null.objectCategory);
               if(_loc4_ != null)
               {
                  _loc9_ = _loc4_.getModel();
                  if(_loc9_ != null)
                  {
                     var_315 = null.objectId;
                     var _loc5_:String = "M";
                     var _loc8_:String = _loc9_.getString("furniture_clothing_boy");
                     if(_loc8_ == null || null == "")
                     {
                        _loc8_ = "hd-99999-99999.lg-270-62";
                     }
                     if(null.gender == "F")
                     {
                        _loc5_ = "F";
                        _loc8_ = _loc9_.getString("furniture_clothing_girl");
                        if(_loc8_ == null || null == "")
                        {
                           _loc8_ = "hd-99999-99999.ch-630-62.lg-695-62";
                        }
                     }
                     if(_container.avatarEditor.openEditor(1,this,["torso","legs"],false,"${widget.furni.clothingchange.editor.title}"))
                     {
                        _container.avatarEditor.loadAvatarInEditor(1,null,null,0);
                        _loc2_ = new RoomWidgetClothingChangeUpdateEvent("RWCCUE_SHOW_GENDER_SELECTION",null.objectId,null.objectCategory,null.roomId);
                        _container.events.dispatchEvent(_loc2_);
                     }
                  }
               }
         }
         return null;
      }
      
      public function update() : void
      {
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function saveFigure(param1:String, param2:String) : void
      {
         if(_container == null)
         {
            return;
         }
         _container.roomSession.sendUpdateClothingChangeFurniture(var_315,param2,param1);
         _container.avatarEditor.close(1);
      }
   }
}

