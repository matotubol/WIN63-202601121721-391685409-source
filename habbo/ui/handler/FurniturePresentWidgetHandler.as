package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.events.RoomSessionPresentEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class FurniturePresentWidgetHandler implements IRoomWidgetHandler, class_1829
   {
      
      private static const const_75:String = "floor";
      
      private static const TYPE_WALLPAPER:String = "wallpaper";
      
      private static const TYPE_LANDSCAPE:String = "landscape";
      
      private static const TYPE_POSTER:String = "poster";
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_315:int = -1;
      
      private var _name:String = "";
      
      public function FurniturePresentWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_PRESENT_WIDGET";
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
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
         return ["RWFWM_MESSAGE_REQUEST_PRESENT","RWPOM_OPEN_PRESENT"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc4_:RoomWidgetFurniToWidgetMessage = null;
         var _loc3_:IRoomObject = null;
         var _loc13_:IRoomObjectModel = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_PRESENT":
               _loc4_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc3_ = _container.roomEngine.getRoomObject(_loc4_.roomId,_loc4_.id,_loc4_.category);
               if(_loc3_ != null)
               {
                  _loc13_ = _loc3_.getModel();
                  if(_loc13_ != null)
                  {
                     var_315 = _loc4_.id;
                     var _loc12_:String = _loc13_.getString("furniture_data");
                     if(_loc12_ == null)
                     {
                        _loc12_ = "";
                     }
                     var _loc8_:String = _loc13_.getString("furniture_purchaser_name");
                     var _loc14_:String = _loc13_.getString("furniture_purchaser_figure");
                     var _loc11_:int = _loc13_.getNumber("furniture_type_id");
                     var _loc5_:String = _loc13_.getString("furniture_extras");
                     var _loc7_:int = 32;
                     var _loc10_:class_2198 = _container.roomEngine.getFurnitureImage(0,new Vector3d(180),0,null,0,null);
                     var _loc6_:* = _loc13_.getNumber("furniture_trusted_sender") == 1;
                     var _loc2_:RoomWidgetPresentDataUpdateEvent = new RoomWidgetPresentDataUpdateEvent("RWPDUE_PACKAGEINFO",_loc4_.id,null,_container.isOwnerOfFurniture(_loc3_),null.data,null,null,false,false,false);
                     _container.events.dispatchEvent(null);
                  }
               }
               break;
            case "RWPOM_OPEN_PRESENT":
               var _loc9_:RoomWidgetPresentOpenMessage = param1 as RoomWidgetPresentOpenMessage;
               if(_loc9_.objectId != var_315)
               {
                  return null;
               }
               if(_container != null)
               {
                  if(_container.roomSession != null)
                  {
                     _container.roomSession.sendPresentOpenMessage(null.objectId);
                  }
                  if(_container.roomEngine != null)
                  {
                     _container.roomEngine.changeObjectModelData(_container.roomEngine.activeRoomId,null.objectId,10,"furniture_disable_picking_animation",1);
                  }
               }
         }
         return null;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed || _container == null)
         {
            return;
         }
         var _loc3_:RoomWidgetPresentDataUpdateEvent = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_IMAGE",0,_name,false,param2);
         _container.events.dispatchEvent(_loc3_);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSPE_PRESENT_OPENED"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc13_:RoomSessionPresentEvent = null;
         if(param1 == null)
         {
            return;
         }
         if(_container != null && _container.events != null && param1 != null)
         {
            var _loc17_:* = param1.type;
            if("RSPE_PRESENT_OPENED" === _loc17_)
            {
               _loc13_ = param1 as RoomSessionPresentEvent;
               if(_loc13_ != null)
               {
                  _name = "";
                  var _loc5_:* = null;
                  if(_loc13_.itemType == "s")
                  {
                     var _loc3_:class_1800 = _container.sessionDataManager.getFloorItemData(_loc13_.classId);
                  }
                  else
                  {
                     while(true)
                     {
                        if(_loc13_.itemType == "i")
                        {
                           _loc3_ = _container.sessionDataManager.getWallItemData(_loc13_.classId);
                        }
                     }
                     §§goto(addr01eb);
                  }
                  var _loc2_:Boolean = false;
                  if(_loc13_.placedInRoom)
                  {
                     while(true)
                     {
                        var _loc11_:IRoomObject = _container.roomEngine.getRoomObject(_container.roomSession.roomId,_loc13_.placedItemId,10);
                        if(_loc11_ != null)
                        {
                           _loc2_ = _container.isOwnerOfFurniture(null);
                        }
                     }
                     §§goto(addr01eb);
                  }
                  switch(_loc13_.itemType)
                  {
                     default:
                        if(_loc13_.placedItemType == "p")
                        {
                           var _loc9_:String = _loc13_.petFigureString;
                           if(_loc9_ != null && null.length > 0)
                           {
                              var _loc12_:PetFigureData = new PetFigureData(null);
                              var _loc16_:int = 2;
                              var _loc7_:int = 64;
                              if(null.typeId == 15)
                              {
                                 _loc7_ = 32;
                              }
                              var _loc15_:class_2198 = _container.roomEngine.getPetImage(null.typeId,null.paletteId,null.color,new Vector3d(0 * 45),0,this,true,0,null.customParts);
                              if(_loc15_ != null)
                              {
                                 _loc5_ = null;
                              }
                           }
                        }
                        _loc5_ = _container.roomEngine.getFurnitureImage(_loc13_.classId,new Vector3d(90),64,this);
                        var _loc6_:class_1949 = _container.sessionDataManager.getProductData(_loc13_.productCode);
                        if(_loc6_ != null)
                        {
                           _name = null.name;
                        }
                        break;
                     case "h":
                        var _loc10_:RoomWidgetPresentDataUpdateEvent = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_CLUB",0,_container.localization.getLocalization("widget.furni.present.hc"),false,null);
                        break;
                     case "i":
                  }
               }
            }
         }
         addr01eb:
      }
      
      public function update() : void
      {
      }
   }
}

