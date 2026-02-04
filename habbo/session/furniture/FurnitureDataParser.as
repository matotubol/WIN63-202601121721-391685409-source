package com.sulake.habbo.session.furniture
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.class_23;
   import com.sulake.core.localization.class_26;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class FurnitureDataParser extends EventDispatcherWrapper
   {
      
      public static const READY:String = "FDP_furniture_data_ready";
      
      private var _floorItems:class_55;
      
      private var _wallItems:class_55;
      
      private var var_2902:class_55;
      
      private var var_969:class_55;
      
      private var _localization:class_26;
      
      private var var_2177:AssetLibrary;
      
      private var var_3768:Boolean;
      
      public function FurnitureDataParser(param1:class_55, param2:class_55, param3:class_55, param4:class_55, param5:class_26, param6:Boolean = true)
      {
         super();
         _floorItems = param1;
         _wallItems = param2;
         var_2902 = param3;
         var_969 = param4;
         _localization = param5;
         var_2177 = new AssetLibrary("FurniDataParserAssetLib");
         var_3768 = param6;
      }
      
      private static function removePatternFrom(param1:Array, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               param1.splice(_loc3_,1);
               _loc3_--;
            }
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_2177)
         {
            var_2177.dispose();
            var_2177 = null;
         }
         _localization = null;
         _floorItems = null;
         _wallItems = null;
         var_2902 = null;
         var_969 = null;
      }
      
      public function loadData(param1:String) : void
      {
         var _loc2_:AssetLoaderStruct = var_2177.loadAssetFromFile("furnidata",new URLRequest(param1),"text/plain");
         _loc2_.addEventListener("AssetLoaderEventComplete",parseFurnitureData);
         _loc2_.addEventListener("AssetLoaderEventError",furnitureDataError);
      }
      
      private function parseFurnitureData(param1:AssetLoaderEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ByteArray = null;
         var _loc4_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc4_ == null)
         {
            return;
         }
         if(_loc4_.assetLoader == null || _loc4_.assetLoader.content == null)
         {
            return;
         }
         if(_loc4_.assetLoader.content is ByteArray)
         {
            _loc3_ = _loc4_.assetLoader.content as ByteArray;
            _loc3_.position = 0;
            _loc2_ = _loc3_.readUTFBytes(_loc3_.length);
         }
         else
         {
            _loc2_ = _loc4_.assetLoader.content as String;
         }
         if(_loc2_.charAt(0) == "<")
         {
            parseXmlFormat(_loc2_);
         }
         else
         {
            parseLingoFormat(_loc2_);
         }
      }
      
      private function parseXmlFormat(param1:String) : void
      {
         var _loc5_:XML = null;
         var _loc2_:XMLList = null;
         var _loc3_:* = null;
         var _loc4_:FurnitureData = null;
         try
         {
            _loc5_ = new XML(param1);
         }
         catch(e:Error)
         {
            class_23.error("XML furni data was malformed: " + param1,var_3768,12);
         }
         if(_loc5_ == null)
         {
            return;
         }
         _loc2_ = _loc5_.roomitemtypes;
         for each(_loc3_ in _loc2_.furnitype)
         {
            _loc4_ = parseFloorItem(_loc3_);
            storeItem(_loc4_);
            registerFurnitureLocalization(_loc4_);
         }
         _loc2_ = _loc5_.wallitemtypes;
         for each(_loc3_ in _loc2_.furnitype)
         {
            _loc4_ = parseWallItem(_loc3_);
            storeItem(_loc4_);
            registerFurnitureLocalization(_loc4_);
         }
         dispatchEvent(new Event("FDP_furniture_data_ready"));
      }
      
      private function parseFloorItem(param1:XML) : FurnitureData
      {
         var _loc5_:String = null;
         var _loc8_:int = parseInt(param1.@id);
         var _loc11_:Array = [];
         for each(var _loc2_ in param1.partcolors.color)
         {
            _loc5_ = _loc2_;
            if(_loc5_.charAt(0) == "#")
            {
               _loc5_ = _loc5_.replace("#","");
               _loc11_.push(parseInt(_loc5_,16));
            }
            else
            {
               _loc11_.push(-parseInt(_loc5_));
            }
         }
         var _loc4_:String = param1.@classname;
         var _loc9_:Array = _loc4_.split("*");
         var _loc7_:String = _loc9_[0];
         var _loc3_:int = _loc9_.length > 1 ? parseInt(_loc9_[1]) : 0;
         var _loc10_:* = _loc9_.length > 1;
         return new FurnitureData("s",_loc8_,_loc4_,_loc7_,param1.name,"",param1.revision,param1.xdim,param1.ydim,0,_loc11_,_loc10_,_loc3_,param1.adurl,param1.offerid,param1.buyout == "1",param1.rentofferid,param1.rentbuyout == "1",param1.bc == "1",param1.customparams,param1.specialtype,param1.canstandon == "1",param1.cansiton == "1",param1.canlayon == "1",param1.excludeddynamic == "1",param1.furniline,param1.bcofferid);
      }
      
      private function parseWallItem(param1:XML) : FurnitureData
      {
         var _loc3_:int = parseInt(param1.@id);
         return new FurnitureData("i",_loc3_,param1.@classname,param1.@classname,param1.name,"",param1.revision,0,0,0,null,false,0,param1.adurl,param1.offerid,param1.buyout == "1",param1.rentofferid,param1.rentbuyout == "1",param1.bc == "1",null,param1.specialtype,false,false,false,param1.excludeddynamic == "1",param1.furniline,param1.bcofferid);
      }
      
      private function parseLingoFormat(param1:String) : void
      {
         var _loc5_:Array = null;
         var _loc29_:Array = null;
         var _loc9_:String = null;
         var _loc19_:int = 0;
         var _loc3_:String = null;
         var _loc37_:Array = null;
         var _loc8_:String = null;
         var _loc23_:int = 0;
         var _loc38_:* = false;
         var _loc30_:int = 0;
         var _loc22_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc41_:Array = null;
         var _loc32_:Array = null;
         var _loc39_:int = 0;
         var _loc26_:String = null;
         var _loc10_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc33_:int = 0;
         var _loc20_:* = false;
         var _loc34_:int = 0;
         var _loc2_:* = false;
         var _loc24_:String = null;
         var _loc40_:int = 0;
         var _loc31_:* = false;
         var _loc13_:* = false;
         var _loc25_:* = false;
         var _loc11_:* = false;
         var _loc36_:* = false;
         var _loc4_:* = false;
         var _loc14_:FurnitureData = null;
         var _loc15_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/gm;
         var _loc12_:RegExp = /^\s+|\s+$/g;
         var _loc35_:RegExp = /\[+?((.)*?)\]/g;
         var _loc28_:Array = param1.split(_loc15_);
         var _loc21_:int = 0;
         for each(var _loc18_ in _loc28_)
         {
            _loc5_ = _loc18_.match(_loc35_);
            for each(var _loc27_ in _loc5_)
            {
               _loc27_ = _loc27_.replace(/\[{1,}/gm,"");
               _loc27_ = _loc27_.replace(/\]{1,}/gm,"");
               _loc29_ = _loc27_.split("\"");
               removePatternFrom(_loc29_,", ");
               removePatternFrom(_loc29_,",");
               _loc29_.splice(0,1);
               _loc29_.splice(_loc29_.length - 1,1);
               if(_loc29_.length < 18)
               {
                  class_23.error("Lingo furni data was malformed: " + param1,true,12);
                  return;
               }
               _loc9_ = _loc29_[0];
               _loc19_ = parseInt(_loc29_[1]);
               _loc3_ = String(_loc29_[2]);
               _loc37_ = _loc3_.split("*");
               _loc8_ = _loc37_[0];
               _loc23_ = _loc37_.length > 1 ? parseInt(_loc37_[1]) : 0;
               _loc38_ = _loc37_.length > 1;
               _loc30_ = parseInt(_loc29_[3]);
               _loc22_ = parseInt(_loc29_[4]);
               _loc16_ = parseInt(_loc29_[5]);
               _loc17_ = parseInt(_loc29_[6]);
               _loc41_ = [];
               _loc32_ = _loc29_[7].split(",");
               _loc39_ = 0;
               while(_loc39_ < _loc32_.length)
               {
                  _loc26_ = _loc32_[_loc39_];
                  if(_loc26_.charAt(0) == "#")
                  {
                     _loc26_ = _loc26_.replace("#","");
                     _loc41_.push(parseInt(_loc26_,16));
                  }
                  else
                  {
                     _loc41_.push(-parseInt(_loc26_));
                  }
                  _loc39_++;
               }
               _loc10_ = _loc29_[8];
               _loc6_ = _loc29_[9];
               _loc7_ = _loc29_[10];
               _loc33_ = parseInt(_loc29_[11]);
               _loc20_ = _loc29_[12] == "true";
               _loc34_ = parseInt(_loc29_[13]);
               _loc2_ = _loc29_[14] == "true";
               _loc24_ = _loc29_[15];
               _loc40_ = parseInt(_loc29_[16]);
               _loc31_ = _loc29_[17] == "true";
               _loc36_ = false;
               _loc4_ = _loc9_ == "i";
               if(_loc4_)
               {
                  _loc13_ = false;
                  _loc25_ = false;
                  _loc11_ = false;
                  if(_loc29_.length >= 19)
                  {
                     _loc36_ = _loc29_[18] == "1";
                  }
               }
               else
               {
                  _loc13_ = _loc29_[18] == "1";
                  _loc25_ = _loc29_[19] == "1";
                  _loc11_ = _loc29_[20] == "1";
                  if(_loc29_.length >= 22)
                  {
                     _loc36_ = _loc29_[21] == "1";
                  }
               }
               _loc14_ = new FurnitureData(_loc9_,_loc19_,_loc3_,_loc8_,_loc10_,"",_loc30_,_loc22_,_loc16_,_loc17_,_loc41_,_loc38_,_loc23_,_loc7_,_loc33_,_loc20_,_loc34_,_loc2_,_loc31_,_loc24_,_loc40_,_loc13_,_loc25_,_loc11_,_loc36_,"",-1);
               storeItem(_loc14_);
               registerFurnitureLocalization(_loc14_);
            }
            _loc21_++;
         }
         dispatchEvent(new Event("FDP_furniture_data_ready"));
      }
      
      private function storeItem(param1:FurnitureData) : void
      {
         if(param1.type == "s")
         {
            _floorItems.add(param1.id,param1);
            var _loc3_:class_55 = var_2902;
         }
         else if(param1.type == "i")
         {
            _wallItems.add(param1.id,param1);
            _loc3_ = var_969;
         }
         var _loc2_:Array = null[param1.className];
         if(_loc2_ == null)
         {
            _loc2_ = [];
            null.add(param1.className,_loc2_);
         }
         _loc2_[param1.colourIndex] = param1.id;
      }
      
      private function furnitureDataError(param1:AssetLoaderEvent) : void
      {
         HabboWebTools.logEventLog("furnituredata download error " + param1.status);
         class_23.error("Could not download furnidata definition",var_3768,12);
      }
      
      private function registerFurnitureLocalization(param1:FurnitureData) : void
      {
         if(_localization != null)
         {
            if(param1.type == "s")
            {
               _localization.updateLocalization("roomItem.name." + param1.id,param1.localizedName);
               _localization.updateLocalization("roomItem.desc." + param1.id,param1.description);
            }
            else if(param1.type == "i")
            {
               _localization.updateLocalization("wallItem.name." + param1.id,param1.localizedName);
               _localization.updateLocalization("wallItem.desc." + param1.id,param1.description);
            }
         }
      }
   }
}

