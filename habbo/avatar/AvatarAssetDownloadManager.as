package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
   import com.sulake.habbo.avatar.structure.class_1780;
   import com.sulake.habbo.avatar.structure.figure.FigurePart;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_1932;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AvatarAssetDownloadManager extends EventDispatcherWrapper
   {
      
      public static const LIBRARY_LOADED:String = "LIBRARY_LOADED";
      
      private static const LIB_BODY:String = "hh_human_body";
      
      private static const LIB_ITEMS:String = "hh_human_item";
      
      private static const LIB_AVATAR_EDITOR:String = "hh_avatar_editor";
      
      private var var_52:class_49;
      
      private var var_614:Dictionary;
      
      private var var_2115:Dictionary;
      
      private var _assets:class_40;
      
      private var var_1652:Dictionary;
      
      private var _listeners:Dictionary;
      
      private var var_74:AvatarStructure;
      
      private var var_4038:String;
      
      private var var_1923:String;
      
      private var var_3640:Boolean;
      
      private var var_2241:int = 3;
      
      private var var_674:AssetLoaderStruct;
      
      private var _downloadShiftTimer:Timer;
      
      private var var_951:Array;
      
      private var var_1762:Array;
      
      private var var_1778:Array;
      
      private const DOWNLOAD_TIMEOUT:int = 100;
      
      private var var_4166:int = 6;
      
      private var var_4126:String;
      
      private var var_1939:Array = ["hh_human_body","hh_human_item"];
      
      public function AvatarAssetDownloadManager(param1:class_49, param2:class_40, param3:String, param4:String, param5:AvatarStructure, param6:String)
      {
         super();
         var_52 = param1;
         var_614 = new Dictionary();
         var_2115 = new Dictionary();
         _assets = param2;
         var_74 = param5;
         var_1652 = new Dictionary();
         var_4038 = param4;
         var_1923 = param3;
         var_4126 = param6;
         _listeners = new Dictionary();
         var_951 = [];
         var_1762 = [];
         var_1778 = [];
         if(param4 && param4.indexOf("//rumba.sulake.com") > 0)
         {
            var_4166 = 16;
         }
         var_74.renderManager.events.addEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
         var _loc7_:URLRequest = new URLRequest(param3);
         var _loc9_:IAsset = _assets.getAssetByName("figuremap");
         if(_loc9_ == null)
         {
            var_674 = _assets.loadAssetFromFile("figuremap",_loc7_,"text/xml");
            addMapLoaderEventListeners();
         }
         else
         {
            var _loc10_:XmlAsset = _assets.getAssetByName("figuremap") as XmlAsset;
            var _loc8_:XML = (_loc10_.content as XML).copy();
            loadFigureMapData(null);
         }
         _downloadShiftTimer = new Timer(100,1);
         _downloadShiftTimer.addEventListener("timerComplete",onNextDownloadTimeout);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2115 = null;
         _assets = null;
         var_1652 = null;
         _listeners = null;
         if(var_74.renderManager)
         {
            var_74.renderManager.events.removeEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
         }
         var_74 = null;
         var_1762 = null;
         var_951 = null;
         if(_downloadShiftTimer)
         {
            _downloadShiftTimer.stop();
            _downloadShiftTimer = null;
         }
         if(var_674)
         {
            removeMapLoaderEventListeners();
            var_674 = null;
         }
      }
      
      private function addMapLoaderEventListeners() : void
      {
         if(var_674)
         {
            var_674.addEventListener("AssetLoaderEventComplete",onConfigurationComplete);
            var_674.addEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function removeMapLoaderEventListeners() : void
      {
         if(var_674)
         {
            var_674.removeEventListener("AssetLoaderEventComplete",onConfigurationComplete);
            var_674.removeEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function onConfigurationError(param1:Event) : void
      {
         if(disposed)
         {
            return;
         }
         var_2241 = var_2241 - 1;
         if(var_2241 <= 0)
         {
            HabboWebTools.logEventLog("Figuremap download error " + var_1923);
         }
         else
         {
            if(var_1923.indexOf("?") > 0)
            {
               var _loc2_:String = var_1923 + "&retry=" + var_2241;
            }
            else
            {
               _loc2_ = var_1923 + "?retry=" + var_2241;
            }
            removeMapLoaderEventListeners();
            var _loc3_:URLRequest = new URLRequest(null);
            var_674 = _assets.loadAssetFromFile("figuremap",null,"text/xml");
            addMapLoaderEventListeners();
         }
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var _loc2_:XML = null;
         if(disposed)
         {
            return;
         }
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc3_ == null)
         {
            return;
         }
         try
         {
            _loc2_ = new XML(_loc3_.assetLoader.content as String);
         }
         catch(e:Error)
         {
            return;
         }
         loadFigureMapData(_loc2_);
      }
      
      private function loadFigureMapData(param1:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.toString() == "")
         {
            return;
         }
         generateMap(param1);
         loadMandatoryLibs();
         var_3640 = true;
         dispatchEvent(new Event("complete"));
      }
      
      public function loadMandatoryLibs() : void
      {
         var _loc2_:AvatarAssetDownloadLibrary = null;
         var _loc1_:Array = var_1939.slice();
         for each(var _loc3_ in _loc1_)
         {
            _loc2_ = var_614[_loc3_];
            if(_loc2_)
            {
               _loc2_.isMandatory = true;
               addToQueue(_loc2_);
            }
            else
            {
               class_21.log("Missing mandatory library: " + _loc3_);
            }
         }
         _downloadShiftTimer.start();
      }
      
      private function purgeInitDownloadBuffer(param1:Event) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_951)
         {
            loadFigureSetData(_loc2_[0],_loc2_[1]);
         }
         var_951 = [];
      }
      
      private function generateMap(param1:XML) : void
      {
         var _loc2_:AvatarAssetDownloadLibrary = null;
         var _loc3_:String = null;
         var _loc6_:Array = null;
         for each(var _loc5_ in param1.lib)
         {
            _loc2_ = new AvatarAssetDownloadLibrary(_loc5_.@id,_loc5_.@revision,var_4038,_assets,var_4126);
            _loc2_.addEventListener("complete",libraryComplete);
            var_614[_loc2_.libraryName] = _loc2_;
            for each(var _loc4_ in _loc5_.part)
            {
               _loc3_ = _loc4_.@type + ":" + _loc4_.@id;
               _loc6_ = var_2115[_loc3_];
               if(_loc6_ == null)
               {
                  _loc6_ = [];
               }
               _loc6_.push(_loc2_);
               var_2115[_loc3_] = _loc6_;
            }
         }
      }
      
      public function isReady(param1:class_1900) : Boolean
      {
         if(!var_3640 || !var_74.renderManager.isReady)
         {
            return false;
         }
         var _loc2_:Array = getLibsToDownload(param1);
         return _loc2_.length == 0;
      }
      
      public function loadFigureSetData(param1:class_1900, param2:class_259) : void
      {
         var _loc5_:Array = null;
         if(!var_3640 || !var_74.renderManager.isReady)
         {
            var_951.push([param1,param2]);
            return;
         }
         var _loc6_:String = param1.getFigureString();
         var _loc4_:Array = getLibsToDownload(param1);
         if(_loc4_.length > 0)
         {
            if(param2 && !param2.disposed)
            {
               _loc5_ = _listeners[_loc6_];
               if(_loc5_ == null)
               {
                  _loc5_ = [];
               }
               _loc5_.push(param2);
               _listeners[_loc6_] = _loc5_;
            }
            var_1652[_loc6_] = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               addToQueue(_loc3_);
            }
            _downloadShiftTimer.start();
         }
         else if(param2 != null && !param2.disposed)
         {
            param2.avatarImageReady(_loc6_);
         }
      }
      
      private function libraryComplete(param1:Event) : void
      {
         var _loc10_:String = null;
         var _loc4_:Array = null;
         var _loc12_:Boolean = false;
         var _loc5_:Array = null;
         var _loc8_:AvatarAssetDownloadLibrary = null;
         var _loc9_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc11_:Array = [];
         for(_loc10_ in var_1652)
         {
            _loc12_ = true;
            _loc4_ = var_1652[_loc10_];
            for each(var _loc3_ in _loc4_)
            {
               if(!_loc3_.isReady)
               {
                  _loc12_ = false;
                  break;
               }
            }
            if(_loc12_)
            {
               _loc11_.push(_loc10_);
               _loc5_ = _listeners[_loc10_];
               for each(var _loc7_ in _loc5_)
               {
                  if(_loc7_ != null && !_loc7_.disposed)
                  {
                     _loc7_.avatarImageReady(_loc10_);
                  }
               }
               delete _listeners[_loc10_];
            }
         }
         for each(_loc10_ in _loc11_)
         {
            delete var_1652[_loc10_];
         }
         var _loc6_:String = (param1.target as AvatarAssetDownloadLibrary).libraryName;
         var _loc2_:int = int(var_1939.indexOf(_loc6_));
         if(_loc2_ != -1)
         {
            var_1939.splice(_loc2_,1);
            if(var_1939.length == 0)
            {
               var_52.onMandatoryLibrariesReady();
            }
         }
         _loc9_ = 0;
         while(_loc9_ < var_1778.length)
         {
            _loc8_ = var_1778[_loc9_];
            if(_loc8_.libraryName == _loc6_)
            {
               var_1778.splice(_loc9_,1);
            }
            _loc9_++;
         }
         if(_loc11_.length > 0)
         {
            dispatchEvent(new LibraryLoadedEvent("LIBRARY_LOADED",_loc6_));
         }
         _downloadShiftTimer.start();
      }
      
      public function isMissingMandatoryLibs() : Boolean
      {
         return var_1939.length > 0;
      }
      
      private function getLibsToDownload(param1:class_1900) : Array
      {
         var _loc12_:ISetType = null;
         var _loc8_:Array = [];
         if(!var_74)
         {
            return _loc8_;
         }
         if(!param1)
         {
            return _loc8_;
         }
         var _loc2_:class_1780 = var_74.figureData;
         if(!_loc2_)
         {
            return _loc8_;
         }
         var _loc10_:Array = param1.getPartTypeIds();
         for each(var _loc6_ in _loc10_)
         {
            _loc12_ = _loc2_.getSetType(_loc6_);
            if(_loc12_)
            {
               var _loc7_:int = param1.getPartSetId(_loc6_);
               var _loc5_:class_1932 = _loc12_.getPartSet(0);
               if(_loc5_)
               {
                  for each(var _loc9_ in null.parts)
                  {
                     var _loc11_:String = _loc9_.type + ":" + _loc9_.id;
                     var _loc4_:Array = var_2115[null];
                     if(_loc4_ != null)
                     {
                        for each(var _loc3_ in null)
                        {
                           if(_loc3_ != null)
                           {
                              if(!_loc3_.isReady)
                              {
                                 if(_loc8_.indexOf(_loc3_) == -1)
                                 {
                                    _loc8_.push(_loc3_);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc8_;
      }
      
      private function processPending() : void
      {
         var _loc1_:AvatarAssetDownloadLibrary = null;
         while(var_1762.length > 0 && var_1778.length < var_4166)
         {
            _loc1_ = var_1762.shift();
            var_1778.push(_loc1_);
            _loc1_.startDownloading();
         }
      }
      
      private function addToQueue(param1:AvatarAssetDownloadLibrary) : void
      {
         if(!param1.isReady && var_1762.indexOf(param1) == -1 && var_1778.indexOf(param1) == -1)
         {
            var_1762.push(param1);
         }
      }
      
      private function onNextDownloadTimeout(param1:Event = null) : void
      {
         processPending();
      }
      
      public function purge() : void
      {
         for each(var _loc1_ in var_614)
         {
            if(_loc1_.isReady && !_loc1_.isMandatory)
            {
               _loc1_.purge();
            }
         }
      }
   }
}

