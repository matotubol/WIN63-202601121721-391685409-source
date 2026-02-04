package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureRoomBrandingLogic extends class_1738
   {
      
      public static const STUFF_DATA_KEY_STATE:String = "state";
      
      public static const STUFF_DATA_KEY_IMAGEURL:String = "imageUrl";
      
      public static const STUFF_DATA_KEY_CLICKURL:String = "clickUrl";
      
      public static const STUFF_DATA_KEY_OFFSET_X:String = "offsetX";
      
      public static const STUFF_DATA_KEY_OFFSET_Y:String = "offsetY";
      
      public static const STUFF_DATA_KEY_OFFSET_Z:String = "offsetZ";
      
      protected var var_4051:Boolean;
      
      protected var var_3024:Boolean;
      
      public function FurnitureRoomBrandingLogic()
      {
         super();
         var_4051 = true;
         var_3024 = false;
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(var_4051)
         {
            object.getModelController().setNumber("furniture_selection_disable",1);
         }
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["RORAE_ROOM_AD_LOAD_IMAGE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:RoomObjectRoomAdUpdateMessage = null;
         super.processUpdateMessage(param1);
         if(param1 is RoomObjectDataUpdateMessage)
         {
            setupImageFromFurnitureData();
         }
         if(param1 is RoomObjectRoomAdUpdateMessage)
         {
            _loc2_ = param1 as RoomObjectRoomAdUpdateMessage;
            switch(_loc2_.type)
            {
               case "RORUM_ROOM_BILLBOARD_IMAGE_LOADED":
                  object.getModelController().setNumber("furniture_branding_image_status",1,false);
                  break;
               case "RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED":
                  object.getModelController().setNumber("furniture_branding_image_status",-1);
                  class_21.log("failed to load billboard image from url " + object.getModelController().getString("furniture_branding_image_url"));
            }
         }
      }
      
      private function setupImageFromFurnitureData() : Boolean
      {
         var _loc9_:MapStuffData = null;
         var _loc2_:Number = NaN;
         var _loc12_:int = 0;
         var _loc14_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc13_:Boolean = false;
         if(object != null)
         {
            _loc9_ = new MapStuffData();
            _loc9_.initializeFromRoomObjectModel(object.getModel());
            _loc2_ = 0;
            if(!isNaN(_loc2_))
            {
               _loc12_ = _loc2_;
               if(object.getState(0) != _loc12_)
               {
                  object.setState(_loc12_,0);
                  _loc13_ = true;
               }
            }
            _loc14_ = forceImageUrlToUseHttps(_loc9_.getValue("imageUrl"));
            if(_loc14_ != null)
            {
               _loc3_ = object.getModelController().getString("furniture_branding_image_url");
               if(_loc3_ == null || forceImageUrlToUseHttps(_loc3_) != _loc14_)
               {
                  object.getModelController().setString("furniture_branding_image_url",_loc14_,false);
                  object.getModelController().setNumber("furniture_branding_image_status",0,false);
                  _loc13_ = true;
               }
            }
            _loc4_ = _loc9_.getValue("clickUrl");
            if(_loc4_ != null)
            {
               _loc5_ = object.getModelController().getString("furniture_branding_url");
               if(_loc5_ == null || _loc5_ != _loc4_)
               {
                  object.getModelController().setString("furniture_branding_url",_loc4_);
                  _loc13_ = true;
               }
            }
            if(!isNaN(parseInt(_loc9_.getValue("offsetX"))))
            {
               _loc13_ = updateOffset("furniture_branding_offset_x",object.getModelController().getNumber("furniture_branding_offset_x"),parseInt(_loc9_.getValue("offsetX")));
            }
            if(!isNaN(parseInt(_loc9_.getValue("offsetY"))))
            {
               _loc13_ = updateOffset("furniture_branding_offset_y",object.getModelController().getNumber("furniture_branding_offset_y"),parseInt(_loc9_.getValue("offsetY")));
            }
            if(!isNaN(parseInt(_loc9_.getValue("offsetZ"))))
            {
               _loc13_ = updateOffset("furniture_branding_offset_z",object.getModelController().getNumber("furniture_branding_offset_z"),parseInt(_loc9_.getValue("offsetZ")));
            }
         }
         var _loc10_:String = object.getModelController().getString("furniture_branding_image_url");
         var _loc1_:String = object.getModelController().getString("furniture_branding_url");
         var _loc6_:int = int(object.getModelController().getNumber("furniture_branding_offset_x"));
         var _loc8_:int = int(object.getModelController().getNumber("furniture_branding_offset_y"));
         var _loc7_:int = int(object.getModelController().getNumber("furniture_branding_offset_z"));
         if(_loc10_ != null)
         {
            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_LOAD_IMAGE",object,_loc10_,_loc1_));
         }
         var _loc11_:String = "imageUrl=" + (_loc10_ ?? "") + "\t";
         if(var_3024)
         {
            _loc11_ += "clickUrl=" + (_loc1_ ?? "") + "\t";
         }
         _loc11_ += "offsetX=" + _loc6_ + "\t";
         _loc11_ = _loc11_ + ("offsetY=" + _loc8_ + "\t");
         _loc11_ = _loc11_ + ("offsetZ=" + _loc7_ + "\t");
         object.getModelController().setString("RWEIEP_INFOSTAND_EXTRA_PARAM","RWEIEP_BRANDING_OPTIONS" + _loc11_);
         return _loc13_;
      }
      
      private function forceImageUrlToUseHttps(param1:String) : String
      {
         return param1 != null ? param1.replace("http:","https:") : null;
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(param1.type == "mouseMove")
         {
            return;
         }
         var _loc3_:* = param1.type;
         if("doubleClick" !== _loc3_)
         {
            super.mouseEvent(param1,param2);
            return;
         }
      }
      
      private function updateOffset(param1:String, param2:int, param3:int) : Boolean
      {
         if(!isNaN(param3) && param2 != param3)
         {
            object.getModelController().setNumber(param1,param3);
            return true;
         }
         return false;
      }
   }
}

