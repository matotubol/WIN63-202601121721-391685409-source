package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class EffectAssetDownloadManager extends EventDispatcherWrapper
   {
      
      public static const LIBRARY_LOADED:String = "LIBRARY_LOADED";
      
      private var var_1939:Array = ["dance.1","dance.2","dance.3","dance.4"];
      
      private var var_1953:Dictionary;
      
      private var var_2241:int = 3;
      
      private var var_674:AssetLoaderStruct;
      
      private var _assets:class_40;
      
      private var var_3640:Boolean;
      
      private var var_1923:String;
      
      private var var_4038:String;
      
      private var var_4126:String;
      
      private var var_74:AvatarStructure;
      
      private var _listeners:Dictionary;
      
      private var var_2351:Dictionary;
      
      private var _downloadShiftTimer:Timer;
      
      private var var_951:Array;
      
      private var var_1762:Array;
      
      private var var_1778:Array;
      
      private const DOWNLOAD_TIMEOUT:int = 100;
      
      private const MAX_SIMULTANEOUS_DOWNLOADS:int = 2;
      
      public function EffectAssetDownloadManager(param1:class_40, param2:String, param3:String, param4:AvatarStructure, param5:String)
      {
         super();
         var_1953 = new Dictionary();
         _assets = param1;
         var_74 = param4;
         var_1923 = param2;
         var_4038 = param3;
         var_4126 = param5;
         _listeners = new Dictionary();
         var_2351 = new Dictionary();
         var_951 = [];
         var_1762 = [];
         var_1778 = [];
         var _loc6_:URLRequest = new URLRequest(var_1923);
         var _loc8_:IAsset = _assets.getAssetByName("effectmap");
         if(_loc8_ == null)
         {
            var_674 = _assets.loadAssetFromFile("effectmap",_loc6_,"text/xml");
            addMapLoaderEventListeners();
         }
         else
         {
            var _loc9_:XmlAsset = _assets.getAssetByName("effectmap") as XmlAsset;
            var _loc7_:XML = (_loc9_.content as XML).copy();
            loadEffectMapData(null);
         }
         _downloadShiftTimer = new Timer(100,1);
         _downloadShiftTimer.addEventListener("timerComplete",onNextDownloadTimeout);
         var_74.renderManager.events.addEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
      }
      
      public function loadMandatoryLibs() : void
      {
         var _loc4_:Array = null;
         var _loc1_:Array = var_1939.slice();
         for each(var _loc3_ in _loc1_)
         {
            _loc4_ = var_1953[_loc3_];
            if(_loc4_ != null)
            {
               for each(var _loc2_ in _loc4_)
               {
                  addToQueue(_loc2_);
               }
            }
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
         loadEffectMapData(_loc2_);
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
            HabboWebTools.logEventLog("Effect download error " + var_1923);
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
            var_674 = _assets.loadAssetFromFile("effectmap",null,"text/xml");
            addMapLoaderEventListeners();
         }
      }
      
      private function loadEffectMapData(param1:XML) : void
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
      
      private function generateMap(param1:XML) : void
      {
         var _loc2_:EffectAssetDownloadLibrary = null;
         var _loc3_:String = null;
         var _loc5_:Array = null;
         for each(var _loc4_ in param1.effect)
         {
            _loc2_ = new EffectAssetDownloadLibrary(_loc4_.@lib,"0",var_4038,_assets,var_4126);
            _loc2_.addEventListener("complete",libraryComplete);
            _loc3_ = _loc4_.@id;
            _loc5_ = var_1953[_loc3_];
            if(_loc5_ == null)
            {
               _loc5_ = [];
            }
            _loc5_.push(_loc2_);
            var_1953[_loc3_] = _loc5_;
         }
      }
      
      private function libraryComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc11_:Array = null;
         var _loc10_:Boolean = false;
         var _loc5_:Array = null;
         var _loc7_:EffectAssetDownloadLibrary = null;
         var _loc8_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc9_:EffectAssetDownloadLibrary = param1.target as EffectAssetDownloadLibrary;
         var_74.registerAnimation(_loc9_.animation);
         for(_loc2_ in var_2351)
         {
            _loc10_ = true;
            _loc11_ = var_2351[_loc2_];
            for each(var _loc3_ in _loc11_)
            {
               if(!_loc3_.isReady)
               {
                  _loc10_ = false;
                  break;
               }
            }
            if(_loc10_)
            {
               _loc4_.push(_loc2_);
               _loc5_ = _listeners[_loc2_];
               for each(var _loc6_ in _loc5_)
               {
                  if(_loc6_ != null && !_loc6_.disposed)
                  {
                     _loc6_.avatarEffectReady(parseInt(_loc2_));
                  }
               }
               delete _listeners[_loc2_];
            }
         }
         for each(_loc2_ in _loc4_)
         {
            delete var_2351[_loc2_];
         }
         while(_loc8_ < var_1778.length)
         {
            _loc7_ = var_1778[_loc8_];
            if(_loc7_.name == _loc9_.name)
            {
               var_1778.splice(_loc8_,1);
            }
            _loc8_++;
         }
         if(_loc4_.length > 0)
         {
            dispatchEvent(new LibraryLoadedEvent("LIBRARY_LOADED",_loc9_.name));
         }
         _downloadShiftTimer.start();
      }
      
      public function isReady(param1:int) : Boolean
      {
         if(!var_3640 || !var_74.renderManager.isReady)
         {
            return false;
         }
         var _loc2_:Array = getLibsToDownload(param1);
         return _loc2_.length == 0;
      }
      
      public function loadEffectData(param1:int, param2:class_1828) : void
      {
         var _loc5_:Array = null;
         if(!var_3640 || !var_74.renderManager.isReady)
         {
            var_951.push([param1,param2]);
            return;
         }
         var _loc4_:Array = getLibsToDownload(param1);
         if(_loc4_.length > 0)
         {
            if(param2 && !param2.disposed)
            {
               _loc5_ = _listeners[String(param1)];
               if(_loc5_ == null)
               {
                  _loc5_ = [];
               }
               _loc5_.push(param2);
               _listeners[String(param1)] = _loc5_;
            }
            var_2351[String(param1)] = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               addToQueue(_loc3_);
            }
         }
         else if(param2 != null && !param2.disposed)
         {
            param2.avatarEffectReady(param1);
            class_21.log("Effect ready to use: " + param1);
         }
      }
      
      private function getLibsToDownload(param1:int) : Array
      {
         var _loc3_:Array = [];
         if(!var_74)
         {
            return _loc3_;
         }
         var _loc4_:Array = var_1953[String(param1)];
         if(_loc4_ != null)
         {
            for each(var _loc2_ in _loc4_)
            {
               if(_loc2_ != null)
               {
                  if(!_loc2_.isReady)
                  {
                     if(_loc3_.indexOf(_loc2_) == -1)
                     {
                        _loc3_.push(_loc2_);
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function processPending() : void
      {
         var _loc1_:EffectAssetDownloadLibrary = null;
         while(var_1762.length > 0 && var_1778.length < 2)
         {
            _loc1_ = var_1762.shift();
            _loc1_.startDownloading();
            var_1778.push(_loc1_);
         }
      }
      
      private function addToQueue(param1:EffectAssetDownloadLibrary) : void
      {
         if(!param1.isReady && var_1762.indexOf(param1) == -1 && var_1778.indexOf(param1) == -1)
         {
            var_1762.push(param1);
            processPending();
         }
      }
      
      private function onNextDownloadTimeout(param1:Event = null) : void
      {
         processPending();
      }
      
      private function purgeInitDownloadBuffer(param1:Event) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_951)
         {
            loadEffectData(_loc2_[0],_loc2_[1]);
         }
         var_951 = [];
      }
      
      public function get map() : Dictionary
      {
         return var_1953;
      }
   }
}

