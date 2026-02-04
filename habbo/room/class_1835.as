package com.sulake.habbo.room
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.class_23;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.utils.class_25;
   import com.sulake.core.utils.class_47;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.room.object.RoomObjectUserTypes;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.furniture.class_60;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.room.IRoomContentLoader;
   import com.sulake.room.events.RoomContentLoadedEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.IRoomObjectVisualizationFactory;
   import com.sulake.room.object.visualization.utils.class_1805;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class class_1835 implements IRoomContentLoader, class_60, class_13
   {
      
      public static const CONTENT_LOADER_READY:String = "RCL_LOADER_READY";
      
      private static const ASSET_LIBRARY_NAME_PREFIX:String = "RoomContentLoader ";
      
      private static const STATE_CREATED:int = 0;
      
      private static const STATE_INITIALIZING:int = 1;
      
      private static const STATE_READY:int = 2;
      
      private static const PLACE_HOLDER_FURNITURE:String = "place_holder";
      
      private static const PLACE_HOLDER_WALL_ITEM:String = "wall_place_holder";
      
      private static const PLACE_HOLDER_PET:String = "pet_place_holder";
      
      private static const PLACE_HOLDER_DEFAULT:String = "place_holder";
      
      private static const ROOM_CONTENT:String = "room";
      
      private static const const_699:String = "tile_cursor";
      
      private static const const_652:String = "selection_arrow";
      
      private static const CONTENT_DROP_DELAY:int = 20000;
      
      private static const COMPRESSION_INTERVAL:int = 30000;
      
      private static const PLACE_HOLDER_TYPES:Array = ["place_holder","wall_place_holder","pet_place_holder","room","tile_cursor","selection_arrow"];
      
      private static const PLACE_HOLDER_TYPES_GPU:Array = ["place_holder","wall_place_holder","pet_place_holder","room","selection_arrow"];
      
      private var var_1639:String;
      
      private var var_614:class_55 = null;
      
      private var name_1:class_55 = null;
      
      private var var_1347:class_55 = null;
      
      private var var_296:class_55 = null;
      
      private var _visualizationFactory:IRoomObjectVisualizationFactory = null;
      
      private var var_61:int = 0;
      
      private var _stateEvents:IEventDispatcher = null;
      
      private var var_1134:Boolean = false;
      
      private var var_5052:Boolean = false;
      
      private var var_765:class_55 = null;
      
      private var var_752:Dictionary = new Dictionary();
      
      private var var_1163:class_55 = null;
      
      private var var_1201:class_55 = null;
      
      private var _wallItems:Dictionary = new Dictionary();
      
      private var var_1540:class_55 = null;
      
      private var var_1575:class_55 = null;
      
      private var var_708:Dictionary = new Dictionary();
      
      private var _petColors:class_55 = null;
      
      private var _petLayers:class_55 = null;
      
      private var var_1221:class_55 = null;
      
      private var var_1046:class_55 = null;
      
      private var var_1019:class_55 = null;
      
      private var var_1422:class_55 = null;
      
      private var var_4791:String;
      
      private var var_5105:String;
      
      private var var_3888:String;
      
      private var var_3722:String;
      
      private var var_3834:String;
      
      private var var_3358:Boolean = false;
      
      private var _lastAssetCompressionTime:uint;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var var_3839:class_40;
      
      private var var_581:class_33;
      
      private var var_637:class_16;
      
      private var var_1813:Array;
      
      public function class_1835(param1:String)
      {
         super();
         var_1639 = param1;
         var_614 = new class_55();
         name_1 = new class_55();
         var_765 = new class_55();
         var_1163 = new class_55();
         var_1201 = new class_55();
         var_1540 = new class_55();
         var_1575 = new class_55();
         var_1422 = new class_55();
         var_1221 = new class_55();
         var_1046 = new class_55();
         var_1019 = new class_55();
         var_296 = new class_55();
         var_1347 = new class_55();
      }
      
      private function get fileProxy() : class_25
      {
         return class_23.instance.fileProxy;
      }
      
      public function set sessionDataManager(param1:ISessionDataManager) : void
      {
         _sessionDataManager = param1;
         if(var_3358)
         {
            var_3358 = false;
            initFurnitureData();
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function set visualizationFactory(param1:IRoomObjectVisualizationFactory) : void
      {
         _visualizationFactory = param1;
      }
      
      public function initialize(param1:IEventDispatcher, param2:class_16) : void
      {
         _stateEvents = param1;
         var_4791 = param2.getProperty("flash.dynamic.download.url");
         var_5105 = param2.getProperty("flash.dynamic.download.name.template");
         var_3888 = param2.getProperty("flash.dynamic.icon.download.name.template");
         var_3722 = param2.getProperty("pet.dynamic.download.url");
         var_3834 = param2.getProperty("pet.dynamic.download.name.template");
         var_637 = param2;
         var_61 = 1;
         initFurnitureData();
         initPetData(param2);
      }
      
      private function initPetData(param1:class_16) : void
      {
         var _loc2_:Array = param1.getProperty("pet.configuration").split(",");
         var _loc3_:int = 0;
         for each(var _loc4_ in _loc2_)
         {
            var_708[_loc4_] = _loc3_;
            var_1575.add(_loc3_,_loc4_);
            _loc3_++;
         }
         _petColors = new class_55();
         _petLayers = new class_55();
      }
      
      private function initFurnitureData() : void
      {
         if(_sessionDataManager == null)
         {
            var_3358 = true;
            return;
         }
         var _loc1_:Vector.<class_1800> = _sessionDataManager.getFurniData(this);
         if(_loc1_ == null)
         {
            return;
         }
         _sessionDataManager.removeFurniDataListener(this);
         populateFurniData(_loc1_);
         var_5052 = true;
         parseIgnoredFurniTypes();
         continueInitilization();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:AssetLibrary = null;
         var _loc4_:class_1805 = null;
         var _loc5_:String = null;
         if(var_614 != null)
         {
            _loc2_ = int(var_614.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = var_614.getWithIndex(_loc3_) as AssetLibrary;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            var_614.dispose();
            var_614 = null;
         }
         if(name_1 != null)
         {
            name_1.dispose();
            name_1 = null;
         }
         if(var_765 != null)
         {
            var_765.dispose();
            var_765 = null;
         }
         if(var_1163)
         {
            var_1163.dispose();
            var_1163 = null;
         }
         if(var_1201 != null)
         {
            var_1201.dispose();
            var_1201 = null;
         }
         if(var_1540)
         {
            var_1540.dispose();
            var_1540 = null;
         }
         if(var_1575 != null)
         {
            var_1575.dispose();
            var_1575 = null;
         }
         if(_petColors != null)
         {
            _petColors.dispose();
            _petColors = null;
         }
         if(_petLayers != null)
         {
            _petLayers.dispose();
            _petLayers = null;
         }
         if(var_1221 != null)
         {
            var_1221.dispose();
            var_1221 = null;
         }
         if(var_1046 != null)
         {
            var_1046.dispose();
            var_1046 = null;
         }
         if(var_1019 != null)
         {
            var_1019.dispose();
            var_1019 = null;
         }
         if(var_1422 != null)
         {
            var_1422.dispose();
            var_1422 = null;
         }
         if(var_296 != null)
         {
            _loc2_ = int(var_296.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = var_296.getWithIndex(_loc3_) as class_1805;
               if(_loc4_ != null)
               {
                  _loc4_.dispose();
               }
               _loc3_++;
            }
            var_296.dispose();
            var_296 = null;
         }
         if(var_1347 != null)
         {
            var_1347.dispose();
            var_1347 = null;
         }
         if(var_752 != null)
         {
            for(_loc5_ in var_752)
            {
               delete var_752[_loc5_];
            }
            var_752 = null;
         }
         if(_wallItems != null)
         {
            for(_loc5_ in _wallItems)
            {
               delete _wallItems[_loc5_];
            }
            _wallItems = null;
         }
         if(var_708 != null)
         {
            for(_loc5_ in var_708)
            {
               delete var_708[_loc5_];
            }
            var_708 = null;
         }
         _stateEvents = null;
         _sessionDataManager = null;
         var_637 = null;
         var_1134 = true;
      }
      
      private function parseIgnoredFurniTypes() : void
      {
         var _loc1_:String = var_637.getProperty("gpu.ignored_furni");
         if(!_loc1_)
         {
            return;
         }
         var_1813 = _loc1_.split(",");
         var _loc2_:int = int(var_1813.length);
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1813[0] = StringUtil.trim(var_1813[0]);
            _loc3_++;
         }
      }
      
      private function isIgnoredFurniType(param1:String) : Boolean
      {
         return var_1813 ? var_1813.indexOf(param1) != -1 : false;
      }
      
      private function populateFurniData(param1:Vector.<class_1800>) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc6_:String = null;
         var _loc8_:int = 0;
         var _loc2_:String = null;
         var _loc7_:String = null;
         var _loc5_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.id;
            _loc6_ = _loc3_.className;
            if(_loc3_.hasIndexedColor)
            {
               _loc6_ = _loc6_ + "*" + _loc3_.colourIndex;
            }
            _loc8_ = _loc3_.revision;
            _loc2_ = _loc3_.adUrl;
            if(_loc2_ != null && _loc2_.length > 0)
            {
               var_1422.add(_loc6_,_loc2_);
            }
            _loc7_ = _loc3_.className;
            if(_loc3_.type == "s")
            {
               var_765.add(_loc4_,_loc6_);
               var_1163.add(_loc6_,_loc4_);
               if(var_752[_loc7_] == null)
               {
                  var_752[_loc7_] = 1;
               }
            }
            else if(_loc3_.type == "i")
            {
               if(_loc6_ == "post.it")
               {
                  _loc6_ = "post_it";
                  _loc7_ = "post_it";
               }
               if(_loc6_ == "post.it.vd")
               {
                  _loc6_ = "post_it_vd";
                  _loc7_ = "post_it_vd";
               }
               var_1201.add(_loc4_,_loc6_);
               var_1540.add(_loc6_,_loc4_);
               if(_wallItems[_loc7_] == null)
               {
                  _wallItems[_loc7_] = 1;
               }
            }
            _loc5_ = var_1221.getValue(_loc7_);
            if(_loc8_ > _loc5_)
            {
               var_1221.remove(_loc7_);
               var_1221.add(_loc7_,_loc8_);
            }
         }
      }
      
      private function continueInitilization() : void
      {
         if(var_5052)
         {
            var_61 = 2;
            if(_stateEvents != null)
            {
               _stateEvents.dispatchEvent(new Event("RCL_LOADER_READY"));
            }
         }
      }
      
      public function setRoomObjectAlias(param1:String, param2:String) : void
      {
         if(var_1046 != null)
         {
            var_1046.remove(param1);
            var_1046.add(param1,param2);
         }
         if(var_1019 != null)
         {
            var_1019.remove(param2);
            var_1019.add(param2,param1);
         }
      }
      
      private function getRoomObjectAlias(param1:String) : String
      {
         var _loc2_:String = null;
         if(var_1046 != null)
         {
            _loc2_ = var_1046.getValue(param1) as String;
         }
         if(_loc2_ == null)
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      private function getRoomObjectOriginalName(param1:String) : String
      {
         var _loc2_:String = null;
         if(var_1019 != null)
         {
            _loc2_ = var_1019.getValue(param1) as String;
         }
         if(_loc2_ == null)
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public function getObjectCategory(param1:String) : int
      {
         if(param1 == null)
         {
            return -2;
         }
         if(var_752[param1] != null)
         {
            return 10;
         }
         if(_wallItems[param1] != null)
         {
            return 20;
         }
         if(var_708[param1] != null)
         {
            return 100;
         }
         if(param1.indexOf("poster") == 0)
         {
            return 20;
         }
         if(param1 == "room")
         {
            return 0;
         }
         if(param1 == "user")
         {
            return 100;
         }
         if(param1 == "pet")
         {
            return 100;
         }
         if(param1 == "bot")
         {
            return 100;
         }
         if(param1 == "rentable_bot")
         {
            return 100;
         }
         if(param1 == "tile_cursor" || param1 == "selection_arrow")
         {
            return 200;
         }
         return -2;
      }
      
      public function getPlaceHolderType(param1:String) : String
      {
         if(var_752[param1] != null)
         {
            return "place_holder";
         }
         if(_wallItems[param1] != null)
         {
            return "wall_place_holder";
         }
         if(var_708[param1] != null)
         {
            return "pet_place_holder";
         }
         return "place_holder";
      }
      
      public function getPlaceHolderTypes() : Array
      {
         return PLACE_HOLDER_TYPES;
      }
      
      public function getActiveObjectType(param1:int) : String
      {
         var _loc2_:String = var_765.getValue(param1) as String;
         if(_loc2_ == null)
         {
            class_21.log("[RoomContentLoader] Could not find type for id: " + param1);
         }
         return getObjectType(_loc2_);
      }
      
      public function getActiveObjectTypeId(param1:String) : int
      {
         return var_1163.getValue(param1);
      }
      
      public function getWallItemType(param1:int, param2:String = null) : String
      {
         var _loc3_:String = var_1201.getValue(param1) as String;
         if(_loc3_ == "poster" && param2 != null)
         {
            _loc3_ += param2;
         }
         return getObjectType(_loc3_);
      }
      
      public function getWallItemTypeId(param1:String) : int
      {
         return var_1540.getValue(param1);
      }
      
      public function getPetType(param1:int) : String
      {
         return var_1575.getValue(param1) as String;
      }
      
      public function getPetTypeId(param1:String) : int
      {
         return var_708[param1];
      }
      
      public function getPetColor(param1:int, param2:int) : PetColorResult
      {
         var _loc3_:class_55 = _petColors[param1];
         if(_loc3_ != null)
         {
            return _loc3_[param2] as PetColorResult;
         }
         return null;
      }
      
      public function getPetColorsByTag(param1:int, param2:String) : Array
      {
         var _loc5_:class_55 = _petColors[param1];
         var _loc3_:Array = [];
         if(_loc5_ != null)
         {
            for each(var _loc4_ in _loc5_.getValues())
            {
               if(_loc4_.tag == param2)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getPetLayerIdForTag(param1:int, param2:String, param3:int = 64) : int
      {
         var _loc4_:class_55 = _petLayers[param1];
         if(_loc4_)
         {
            var _loc5_:Dictionary = _loc4_[param3.toString()];
            if(_loc5_)
            {
               return null[param2] ?? -1;
            }
         }
         return -1;
      }
      
      public function getPetDefaultPalette(param1:int, param2:String) : PetColorResult
      {
         var _loc4_:class_55 = _petColors[param1];
         if(_loc4_ != null)
         {
            for each(var _loc3_ in _loc4_.getValues())
            {
               if(_loc3_.layerTags.indexOf(param2) > -1 && _loc3_.isMaster)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function getActiveObjectColorIndex(param1:int) : int
      {
         var _loc2_:String = var_765.getValue(param1) as String;
         return getObjectColorIndex(_loc2_);
      }
      
      public function getWallItemColorIndex(param1:int) : int
      {
         var _loc2_:String = var_1201.getValue(param1) as String;
         return getObjectColorIndex(_loc2_);
      }
      
      public function getRoomObjectAdURL(param1:String) : String
      {
         if(var_1422.getValue(param1) != null)
         {
            return var_1422.getValue(param1);
         }
         return "";
      }
      
      private function getObjectType(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = int(param1.indexOf("*"));
         if(_loc2_ >= 0)
         {
            param1 = param1.substr(0,_loc2_);
         }
         return param1;
      }
      
      private function getObjectColorIndex(param1:String) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         var _loc2_:int = int(param1.indexOf("*"));
         if(_loc2_ >= 0)
         {
            var _loc3_:int = int(param1.substr(_loc2_ + 1));
         }
         return 0;
      }
      
      public function getContentType(param1:String) : String
      {
         return param1;
      }
      
      public function hasInternalContent(param1:String) : Boolean
      {
         param1 = RoomObjectUserTypes.getVisualizationType(param1);
         if(param1 == "user" || param1 == "game_snowball" || param1 == "game_snowsplash")
         {
            return true;
         }
         return false;
      }
      
      private function getObjectRevision(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = getObjectCategory(param1);
         if(_loc2_ == 10 || _loc2_ == 20)
         {
            if(param1.indexOf("poster") == 0)
            {
               param1 = "poster";
            }
            return var_1221.getValue(param1);
         }
         return 0;
      }
      
      private function getObjectContentURLs(param1:String, param2:String = null, param3:Boolean = false) : Array
      {
         var _loc7_:String;
         switch(_loc7_ = getContentType(param1))
         {
            case "place_holder":
               return [resolveLocalOrAssetBaseUrl("PlaceHolderFurniture.swf")];
            case "wall_place_holder":
               return [resolveLocalOrAssetBaseUrl("PlaceHolderWallItem.swf")];
            case "pet_place_holder":
               return [resolveLocalOrAssetBaseUrl("PlaceHolderPet.swf")];
            case "room":
               return [resolveLocalOrAssetBaseUrl("HabboRoomContent.swf")];
            case "tile_cursor":
               return [resolveLocalOrAssetBaseUrl("TileCursor.swf")];
            case "selection_arrow":
               return [resolveLocalOrAssetBaseUrl("SelectionArrow.swf")];
            default:
               var _loc6_:int = getObjectCategory(_loc7_);
               if(_loc6_ == 10 || 0 == 20)
               {
                  var _loc4_:String = getRoomObjectAlias(_loc7_);
                  var _loc8_:String = param3 ? var_3888 : var_5105;
                  _loc8_ = _loc8_.replace(/%typeid%/,null);
                  var _loc10_:int = getObjectRevision(_loc7_);
                  _loc8_ = null.replace(/%revision%/,0);
                  if(param3)
                  {
                     var _loc5_:Boolean = param2 != null && param2 != "" && var_1163.hasKey(param1 + "*" + param2);
                     _loc8_ = null.replace(/%param%/,"");
                  }
                  return [var_4791 + null];
               }
               return [];
         }
      }
      
      private function resolveLocalOrAssetBaseUrl(param1:String) : String
      {
         var _loc2_:* = null;
         if(fileProxy && fileProxy.localFileExists(param1))
         {
            return fileProxy.localFilePath(param1);
         }
         return var_3722 + param1;
      }
      
      public function insertObjectContent(param1:int, param2:int, param3:class_40) : Boolean
      {
         var _loc5_:String = getAssetLibraryType(param3);
         switch(param2 - 10)
         {
            case 0:
               var_765[param1] = _loc5_;
               var_1163.add(_loc5_,param1);
               break;
            case 10:
               var_1201[param1] = _loc5_;
               break;
            default:
               throw new Error("Registering content library for unsupported category " + param2 + "!");
         }
         var _loc4_:AssetLibraryCollection = addAssetLibraryCollection(_loc5_,null) as AssetLibraryCollection;
         if(_loc4_)
         {
            _loc4_.addAssetLibrary(param3);
            if(initializeGraphicAssetCollection(_loc5_,param3))
            {
               switch(param2 - 10)
               {
                  case 0:
                     if(var_752[_loc5_] == null)
                     {
                        var_752[_loc5_] = 1;
                     }
                     break;
                  case 10:
                     if(_wallItems[_loc5_] == null)
                     {
                        _wallItems[_loc5_] = 1;
                     }
                     break;
                  default:
                     throw new Error("Registering content library for unsupported category " + param2 + "!");
               }
               var _loc6_:Event = new RoomContentLoadedEvent("RCLE_SUCCESS",_loc5_);
               var _loc7_:IEventDispatcher = getAssetLibraryEventDispatcher(_loc5_,true);
               if(_loc7_)
               {
                  null.dispatchEvent(null);
               }
               return true;
            }
         }
         return false;
      }
      
      public function getObjectUrl(param1:String, param2:String) : String
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(param1 && param1.indexOf(",") >= 0)
         {
            _loc4_ = param1;
            param1 = _loc4_.split(",")[0];
         }
         if(_loc4_ != null)
         {
            _loc3_ = getObjectContentURLs(_loc4_,param2,true);
         }
         else
         {
            _loc3_ = getObjectContentURLs(param1,param2,true);
         }
         if(_loc3_.length > 0)
         {
            return _loc3_[0] as String;
         }
         return null;
      }
      
      public function loadThumbnailContent(param1:int, param2:String, param3:String, param4:IEventDispatcher) : Boolean
      {
         var _loc7_:Array = null;
         var _loc9_:int = 0;
         var _loc6_:String = null;
         var _loc5_:* = null;
         var _loc8_:AssetLoaderStruct = null;
         var _loc10_:String = null;
         if(param2 && param2.indexOf(",") >= 0)
         {
            _loc10_ = param2;
            param2 = _loc10_.split(",")[0];
         }
         if(_loc10_ != null)
         {
            _loc7_ = getObjectContentURLs(_loc10_,param3,true);
         }
         else
         {
            _loc7_ = getObjectContentURLs(param2,param3,true);
         }
         if(_loc7_ != null && _loc7_.length > 0)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc7_.length)
            {
               _loc5_ = _loc6_ = _loc7_[_loc9_];
               _loc8_ = var_3839.loadAssetFromFile([param2,param3].join("_"),new URLRequest(_loc5_),"image/png",param1);
               _loc8_.addEventListener("AssetLoaderEventComplete",onContentLoaded);
               _loc9_++;
            }
            return true;
         }
         return false;
      }
      
      public function loadObjectContent(param1:String, param2:IEventDispatcher) : Boolean
      {
         var _loc5_:Array = null;
         var _loc7_:int = 0;
         var _loc6_:class_47 = null;
         var _loc4_:String = null;
         var _loc3_:* = null;
         if(param1 == null || param1 == "")
         {
            class_21.log("[RoomContentLoader] Can not load content, object type unknown!");
            return false;
         }
         var _loc9_:String = null;
         if(param1 && param1.indexOf(",") >= 0)
         {
            _loc9_ = param1;
            param1 = _loc9_.split(",")[0];
         }
         if(getAssetLibrary(param1) != null || getAssetLibraryEventDispatcher(param1) != null)
         {
            return false;
         }
         var _loc8_:AssetLibraryCollection = addAssetLibraryCollection(param1,param2) as AssetLibraryCollection;
         if(_loc8_ == null)
         {
            return false;
         }
         if(isIgnoredFurniType(param1))
         {
            class_21.log("Ignored object type found from configuration. Not downloading assets for: " + param1);
            return false;
         }
         if(_loc9_ != null)
         {
            _loc5_ = getObjectContentURLs(_loc9_);
         }
         else
         {
            _loc5_ = getObjectContentURLs(param1);
         }
         if(_loc5_ != null && _loc5_.length > 0)
         {
            _loc8_.addEventListener("AssetLibraryLoaded",onContentLoaded);
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc6_ = new class_47();
               _loc3_ = _loc4_ = _loc5_[_loc7_];
               _loc8_.loadFromFile(_loc6_,true);
               _loc6_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",onContentLoadError);
               _loc6_.load(new URLRequest(_loc3_));
               _loc7_++;
            }
            return true;
         }
         return false;
      }
      
      private function onContentLoadError(param1:Event) : void
      {
         var _loc3_:Array = null;
         var _loc4_:class_47 = class_47(param1.target);
         var _loc5_:Array = getPlaceHolderTypes();
         for each(var _loc2_ in _loc5_)
         {
            _loc3_ = getObjectContentURLs(_loc2_);
            if(_loc3_.length > 0 && _loc4_.url != null && _loc4_.url.indexOf(_loc3_[0]) == 0)
            {
               class_23.crash("Failed to load asset: " + _loc4_.url,3);
               return;
            }
         }
      }
      
      private function onContentLoaded(param1:Event) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         var _loc3_:class_40 = null;
         if(disposed)
         {
            return;
         }
         if(param1.target is AssetLoaderStruct)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            var_581.iconLoaded(_loc2_.assetLoader.id,_loc2_.assetName,true);
         }
         else
         {
            _loc3_ = param1.target as class_40;
            if(_loc3_ == null)
            {
               return;
            }
            processLoadedLibrary(_loc3_);
         }
      }
      
      private function processLoadedLibrary(param1:class_40) : void
      {
         var _loc3_:RoomContentLoadedEvent = null;
         var _loc4_:String = getAssetLibraryType(param1);
         _loc4_ = getRoomObjectOriginalName(_loc4_);
         if(_loc4_ != null)
         {
            var _loc2_:Boolean = initializeGraphicAssetCollection(_loc4_,param1);
         }
         _loc3_ = new RoomContentLoadedEvent("RCLE_FAILURE",_loc4_);
         var _loc5_:IEventDispatcher = getAssetLibraryEventDispatcher(_loc4_,true);
         if(_loc5_ != null && _loc3_ != null)
         {
            _loc5_.dispatchEvent(_loc3_);
         }
      }
      
      private function extractPetDataFromLoadedContent(param1:String) : void
      {
         var _loc7_:class_55 = null;
         var _loc5_:Array = null;
         var _loc9_:Array = null;
         var _loc13_:XML = null;
         var _loc8_:int = 0;
         var _loc16_:int = 0;
         var _loc2_:Array = null;
         var _loc14_:Boolean = false;
         var _loc11_:class_55 = null;
         var _loc17_:Dictionary = null;
         var _loc10_:String = null;
         var _loc15_:String = null;
         var _loc19_:int = int(var_708[param1]);
         var _loc6_:class_1805 = getGraphicAssetCollection(param1);
         if(_loc6_ != null)
         {
            _loc7_ = new class_55();
            _loc5_ = _loc6_.getPaletteNames();
            for each(var _loc12_ in _loc5_)
            {
               _loc9_ = _loc6_.getPaletteColors(_loc12_);
               if(_loc9_ != null && _loc9_.length >= 2)
               {
                  _loc13_ = _loc6_.getPaletteXML(_loc12_);
                  _loc8_ = int(_loc13_.@breed);
                  _loc16_ = int(_loc13_.hasOwnProperty("@colortag") ? _loc13_.@colortag : -1);
                  _loc2_ = _loc13_.hasOwnProperty("@tags") ? String(_loc13_.@tags).split(",") : [];
                  _loc14_ = _loc13_.hasOwnProperty("@master") ? String(_loc13_.@master) == "true" : false;
                  _loc7_.add(_loc12_,new PetColorResult(_loc9_[0],_loc9_[1],_loc8_,_loc16_,_loc12_,_loc14_,_loc2_));
               }
            }
            _petColors.add(_loc19_,_loc7_);
         }
         var _loc4_:XML = getVisualizationXML(param1);
         if(_loc4_ != null)
         {
            _loc11_ = new class_55();
            for each(var _loc3_ in _loc4_.visualization)
            {
               _loc17_ = new Dictionary();
               for each(var _loc18_ in _loc3_.layers.layer)
               {
                  if(_loc18_.hasOwnProperty("@tag"))
                  {
                     _loc10_ = _loc18_.@tag;
                     _loc17_[_loc10_] = parseInt(String(_loc18_.@id));
                  }
               }
               _loc15_ = _loc3_.@size;
               _loc11_.add(_loc15_,_loc17_);
            }
            _petLayers.add(_loc19_,_loc11_);
         }
      }
      
      private function initializeGraphicAssetCollection(param1:String, param2:class_40) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc5_:class_1805 = createGraphicAssetCollection(param1,param2);
         if(_loc5_ != null)
         {
            var _loc4_:XML = getAssetXML(param1);
            if(_loc5_.define(null))
            {
               var _loc3_:Boolean = true;
            }
            else
            {
               disposeGraphicAssetCollection(param1);
            }
         }
         return false;
      }
      
      public function extractObjectContent(param1:String, param2:String) : Boolean
      {
         var _loc3_:class_40 = getAssetLibrary(param1);
         var_1347.add(param2,param1);
         if(initializeGraphicAssetCollection(param2,_loc3_))
         {
            return true;
         }
         var_1347.remove(param2);
         return false;
      }
      
      private function getAssetLibraryName(param1:String) : String
      {
         return "RoomContentLoader " + param1;
      }
      
      private function getAssetLibrary(param1:String) : class_40
      {
         var _loc4_:String = getContentType(param1);
         _loc4_ = getRoomObjectOriginalName(_loc4_);
         var _loc2_:class_40 = var_614.getValue(getAssetLibraryName(_loc4_)) as class_40;
         if(_loc2_ == null)
         {
            var _loc3_:String = var_1347.getValue(_loc4_);
         }
         return _loc2_;
      }
      
      private function addAssetLibraryCollection(param1:String, param2:IEventDispatcher) : class_40
      {
         var _loc5_:String = getContentType(param1);
         var _loc3_:class_40 = getAssetLibrary(param1);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         var _loc4_:String = getAssetLibraryName(_loc5_);
         _loc3_ = new AssetLibraryCollection(_loc4_);
         var_614.add(_loc4_,_loc3_);
         if(param2 != null && getAssetLibraryEventDispatcher(param1) == null)
         {
            name_1.add(_loc5_,param2);
         }
         return _loc3_;
      }
      
      private function getAssetLibraryEventDispatcher(param1:String, param2:Boolean = false) : IEventDispatcher
      {
         var _loc3_:String = getContentType(param1);
         if(!param2)
         {
            return name_1.getValue(_loc3_);
         }
         return name_1.remove(_loc3_);
      }
      
      private function getIconAssetType(param1:AssetLoaderStruct) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:String = param1.assetName;
         var _loc2_:Array = _loc4_.split("_");
         var _loc5_:int = parseInt(_loc2_.pop());
         var _loc3_:String = _loc2_.join("_");
         return _loc5_ > 0 ? _loc3_ + "*" + _loc5_ : _loc3_;
      }
      
      private function getAssetLibraryType(param1:class_40) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:IAsset = param1.getAssetByName("index");
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.@type;
      }
      
      public function getVisualizationType(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:class_40 = getAssetLibrary(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc4_:IAsset = _loc2_.getAssetByName(param1 + "_index");
         if(_loc4_ == null)
         {
            _loc4_ = _loc2_.getAssetByName("index");
         }
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc3_:XML = _loc4_.content as XML;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.@visualization;
      }
      
      public function getLogicType(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:class_40 = getAssetLibrary(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc4_:IAsset = _loc2_.getAssetByName(param1 + "_index");
         if(_loc4_ == null)
         {
            _loc4_ = _loc2_.getAssetByName("index");
         }
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc3_:XML = _loc4_.content as XML;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.@logic;
      }
      
      public function hasVisualizationXML(param1:String) : Boolean
      {
         return hasXML(param1,"_visualization");
      }
      
      public function getVisualizationXML(param1:String) : XML
      {
         return getXML(param1,"_visualization");
      }
      
      public function hasAssetXML(param1:String) : Boolean
      {
         return hasXML(param1,"_assets");
      }
      
      public function getAssetXML(param1:String) : XML
      {
         return getXML(param1,"_assets");
      }
      
      public function hasLogicXML(param1:String) : Boolean
      {
         return hasXML(param1,"_logic");
      }
      
      public function getLogicXML(param1:String) : XML
      {
         return getXML(param1,"_logic");
      }
      
      private function getXML(param1:String, param2:String) : XML
      {
         var _loc3_:class_40 = getAssetLibrary(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc7_:String = getContentType(param1);
         var _loc5_:String = getRoomObjectAlias(_loc7_);
         var _loc6_:IAsset = _loc3_.getAssetByName(_loc5_ + param2);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc4_:XML = _loc6_.content as XML;
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_;
      }
      
      private function hasXML(param1:String, param2:String) : Boolean
      {
         var _loc3_:class_40 = getAssetLibrary(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc5_:String = getContentType(param1);
         var _loc4_:String = getRoomObjectAlias(_loc5_);
         return _loc3_.hasAsset(_loc4_ + param2);
      }
      
      public function addGraphicAsset(param1:String, param2:String, param3:BitmapData, param4:Boolean, param5:Boolean = true) : Boolean
      {
         var _loc6_:class_1805 = getGraphicAssetCollection(param1);
         if(_loc6_ != null)
         {
            return _loc6_.addAsset(param2,param3,param4,0,0,false,false);
         }
         return false;
      }
      
      private function createGraphicAssetCollection(param1:String, param2:class_40) : class_1805
      {
         var _loc3_:class_1805 = getGraphicAssetCollection(param1);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         if(param2 == null)
         {
            return null;
         }
         _loc3_ = _visualizationFactory.createGraphicAssetCollection();
         if(_loc3_ != null)
         {
            _loc3_.assetLibrary = param2;
            var_296.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      public function getGraphicAssetCollection(param1:String) : class_1805
      {
         var _loc2_:String = getContentType(param1);
         return var_296.getValue(_loc2_) as class_1805;
      }
      
      public function roomObjectCreated(param1:IRoomObject, param2:String) : void
      {
         var _loc3_:IRoomObjectController = param1 as IRoomObjectController;
         if(_loc3_ && _loc3_.getModelController())
         {
            _loc3_.getModelController().setString("object_room_id",param2,true);
         }
      }
      
      private function disposeGraphicAssetCollection(param1:String) : Boolean
      {
         var _loc2_:String = getContentType(param1);
         if(var_296[_loc2_] != null)
         {
            var _loc3_:class_1805 = var_296.remove(_loc2_);
            return true;
         }
         return false;
      }
      
      public function furniDataReady() : void
      {
         initFurnitureData();
      }
      
      public function setActiveObjectType(param1:int, param2:String) : void
      {
         var_765.remove(param1);
         var_765.add(param1,param2);
      }
      
      public function compressAssets() : void
      {
         var _loc5_:class_1805 = null;
         var _loc10_:String = null;
         var _loc7_:int = 0;
         var _loc2_:String = null;
         var _loc3_:class_40 = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:BitmapDataAsset = null;
         var _loc1_:int = int(var_296.length);
         var _loc6_:Array = getPlaceHolderTypes();
         _loc7_ = _loc1_ - 1;
         while(_loc7_ > -1)
         {
            _loc10_ = var_296.getKey(_loc7_);
            if(_loc6_.indexOf(_loc10_) == -1)
            {
               _loc5_ = var_296.getValue(_loc10_);
               _loc2_ = getAssetLibraryName(_loc10_);
               _loc3_ = var_614.getValue(_loc2_) as class_40;
               if(_loc3_)
               {
                  _loc4_ = int(_loc3_.numAssets);
                  _loc8_ = 0;
                  while(_loc8_ < _loc4_)
                  {
                     _loc9_ = _loc3_.getAssetByIndex(_loc8_) as BitmapDataAsset;
                     if(!_loc9_)
                     {
                     }
                     _loc8_++;
                  }
               }
            }
            _loc7_--;
         }
         _lastAssetCompressionTime = getTimer();
      }
      
      public function purge() : void
      {
         var _loc7_:String = null;
         var _loc5_:int = 0;
         if(var_1134)
         {
            return;
         }
         var _loc1_:int = int(var_296.length);
         var _loc6_:int = getTimer();
         _loc5_ = _loc1_ - 1;
         while(_loc5_ > -1)
         {
            _loc7_ = var_296.getKey(_loc5_);
            if(PLACE_HOLDER_TYPES.indexOf(_loc7_) < 0)
            {
               var _loc4_:class_1805 = var_296.getValue(_loc7_);
               if(_loc4_ && null.getReferenceCount() < 1 && _loc6_ - null.getLastReferenceTimeStamp() >= 20000)
               {
                  var_296.remove(_loc7_);
                  null.dispose();
                  var _loc2_:String = getAssetLibraryName(_loc7_);
                  var _loc3_:class_40 = var_614.getValue(null) as class_40;
               }
            }
            _loc5_--;
         }
      }
      
      public function set iconAssets(param1:class_40) : void
      {
         var_3839 = param1;
      }
      
      public function set iconListener(param1:class_33) : void
      {
         var_581 = param1;
      }
   }
}

