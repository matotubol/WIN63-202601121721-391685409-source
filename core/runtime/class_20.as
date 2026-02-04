package com.sulake.core.runtime
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.class_23;
   import com.sulake.core.runtime.events.LibraryProgressEvent;
   import com.sulake.core.utils.LibraryLoaderQueue;
   import com.sulake.core.utils.class_25;
   import com.sulake.core.utils.class_47;
   import com.sulake.core.utils.class_504;
   import com.sulake.core.utils.class_54;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public final class class_20 extends class_18 implements class_19
   {
      
      private static const NUM_UPDATE_RECEIVER_LEVELS:uint = 3;
      
      private static const CONFIG_XML_NODE_ASSET_LIBRARIES:String = "asset-libraries";
      
      private static const CONFIG_XML_NODE_ASSET_LIBRARY:String = "library";
      
      private static const CONFIG_XML_NODE_SERVICE_LIBRARIES:String = "service-libraries";
      
      private static const CONFIG_XML_NODE_SERVICE_LIBRARY:String = "library";
      
      private static const CONFIG_XML_NODE_COMPONENT_LIBRARIES:String = "component-libraries";
      
      private static const CONFIG_XML_NODE_COMPONENT_LIBRARY:String = "library";
      
      private static var var_3856:class_25;
      
      private var var_736:LibraryLoaderQueue;
      
      private var _loadingEventDelegate:IEventDispatcher;
      
      private var _numberOfFilesInConfig:uint;
      
      private var var_243:Function;
      
      private var var_475:Profiler;
      
      private var var_3032:class_12;
      
      private var var_580:Array;
      
      private var var_1292:Array;
      
      private var _lastUpdateTimeMs:uint;
      
      private var var_2654:uint = 0;
      
      private var _hibernationLevel:int = -1;
      
      private var _hibernationUpdateFrequency:uint;
      
      private var var_527:Dictionary;
      
      private var _rebootOnNextFrame:Boolean;
      
      public function class_20(param1:DisplayObjectContainer, param2:class_12, param3:uint, param4:Dictionary)
      {
         super(this,2,new AssetLibraryCollection("_core_assets"));
         if(param4 == null)
         {
            param4 = new Dictionary();
         }
         var_527 = param4;
         var_2654 = param3;
         var_1649 = (param3 & 0x0F) == 15;
         var_580 = [];
         var_1292 = [];
         var_727 = param1;
         var_3032 = param2;
         var _loc5_:uint = 0;
         while(true)
         {
            var_580.push([]);
            var_1292.push(0);
            _loc5_ = 0 + 1;
         }
      }
      
      private static function writeObjectToProxy(param1:String, param2:Object) : Boolean
      {
         var _loc3_:class_25 = null;
         var _loc4_:ByteArray = null;
         try
         {
            _loc3_ = class_23.instance.fileProxy;
            if(_loc3_)
            {
               _loc4_ = new ByteArray();
               _loc4_.writeObject(param2);
               _loc3_.writeCache(param1,_loc4_);
               return true;
            }
            return false;
         }
         catch(e:Error)
         {
            class_21.log("Caught error when writing Object (" + param1 + ") to IFileProxy: " + e.toString());
            var _loc8_:Boolean = false;
         }
         return _loc8_;
      }
      
      private static function readObjectFromProxy(param1:String) : Object
      {
         var _loc2_:class_25 = null;
         var _loc3_:ByteArray = null;
         try
         {
            _loc2_ = class_23.instance.fileProxy;
            if(_loc2_)
            {
               _loc3_ = _loc2_.readCache(param1);
               if(_loc3_)
               {
                  return _loc3_.readObject();
               }
            }
            return null;
         }
         catch(e:Error)
         {
            class_21.log("Caught error when reading Object (" + param1 + ") from IFileProxy: " + e.toString());
            var _loc7_:* = null;
         }
         return _loc7_;
      }
      
      public function set fileProxy(param1:class_25) : void
      {
         var_3856 = param1;
      }
      
      public function get fileProxy() : class_25
      {
         return var_3856;
      }
      
      public function getNumberOfFilesPending() : uint
      {
         return var_736.length;
      }
      
      public function getNumberOfFilesLoaded() : uint
      {
         return _numberOfFilesInConfig - getNumberOfFilesPending();
      }
      
      public function get arguments() : Dictionary
      {
         return var_527;
      }
      
      public function clearArguments() : void
      {
         var_527 = new Dictionary();
      }
      
      public function initialize() : void
      {
         if(hasLockedComponents())
         {
            events.addEventListener("COMPONENT_EVENT_UNLOCKED",unlockEventHandler);
         }
         else
         {
            doInitialize();
         }
      }
      
      private function unlockEventHandler(param1:Event) : void
      {
         if(!hasLockedComponents())
         {
            events.removeEventListener("COMPONENT_EVENT_UNLOCKED",unlockEventHandler);
            doInitialize();
         }
      }
      
      private function doInitialize() : void
      {
         events.dispatchEvent(new Event("COMPONENT_EVENT_RUNNING"));
         class_504.start();
      }
      
      public function hasLockedComponents() : Boolean
      {
         if(var_280 != null)
         {
            for each(var _loc1_ in var_280)
            {
               if(_loc1_.locked)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getLockedComponents() : Array
      {
         var _loc2_:Array = [];
         if(var_280 != null)
         {
            for each(var _loc1_ in var_280)
            {
               if(_loc1_.locked)
               {
                  _loc2_.push(_loc1_);
               }
            }
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         var _loc2_:Array = null;
         var _loc1_:* = undefined;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(!disposed)
         {
            debug("Disposing core");
            class_504.stop();
            try
            {
               _loc4_ = 0;
               while(_loc4_ < 3)
               {
                  _loc2_ = var_580[_loc4_] as Array;
                  _loc3_ = _loc2_.length;
                  while(_loc3_-- > 0)
                  {
                     _loc1_ = _loc2_.pop();
                     if(_loc1_ is UpdateDelegate)
                     {
                        UpdateDelegate(_loc1_).dispose();
                     }
                  }
                  _loc4_++;
               }
            }
            catch(e:Error)
            {
            }
            if(var_727)
            {
               var_727.removeEventListener("enterFrame",onEnterFrame);
               var_727 = null;
            }
            if(var_736 != null)
            {
               var_736.dispose();
               var_736 = null;
            }
            super.dispose();
         }
      }
      
      override public function error(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : Boolean
      {
         super.error(param1,param2,param3,param4);
         var_3032.logError(param1,param2,param3,param4);
         if(param2 && isCrashOnCriticalError && !isExcludedFromCrash(param3))
         {
            dispose();
            return true;
         }
         return false;
      }
      
      private function get isCrashOnCriticalError() : Boolean
      {
         return getBoolean("error_handling.crash_on_critical_error");
      }
      
      private function isExcludedFromCrash(param1:int) : Boolean
      {
         var _loc2_:String = getProperty("error_handling.exclude_crashing");
         if(!_loc2_)
         {
            return false;
         }
         var _loc3_:Array = _loc2_.split(",");
         return _loc3_.indexOf(param1.toString()) != -1;
      }
      
      public function readConfigDocument(param1:XML, param2:IEventDispatcher = null) : void
      {
         var _loc6_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         debug("Parsing config document");
         _loadingEventDelegate = param2;
         if(var_736 == null)
         {
            var_736 = new LibraryLoaderQueue(var_1649);
         }
         var _loc3_:XML = param1.child("asset-libraries")[0];
         _loc3_ = param1.child("service-libraries")[0];
         _loc3_ = param1.child("component-libraries")[0];
         if(!disposed)
         {
            updateLoadingProcess();
         }
      }
      
      public function writeDictionaryToProxy(param1:String, param2:Dictionary) : Boolean
      {
         return writeObjectToProxy(param1,param2);
      }
      
      public function readDictionaryFromProxy(param1:String) : Dictionary
      {
         return readObjectFromProxy(param1) as Dictionary;
      }
      
      public function writeXMLToProxy(param1:String, param2:XML) : Boolean
      {
         return writeObjectToProxy(param1,param2);
      }
      
      public function readXMLFromProxy(param1:String) : XML
      {
         return readObjectFromProxy(param1) as XML;
      }
      
      public function readStringFromProxy(param1:String) : String
      {
         var _loc2_:class_25 = null;
         var _loc3_:ByteArray = null;
         try
         {
            _loc2_ = class_23.instance.fileProxy;
            if(_loc2_)
            {
               _loc3_ = _loc2_.readCache(param1);
               if(_loc3_)
               {
                  return _loc3_.readUTFBytes(_loc3_.length);
               }
            }
            return null;
         }
         catch(e:Error)
         {
            class_21.log("Caught error when reading Object (" + param1 + ") from IFileProxy: " + e.toString());
            var _loc7_:* = null;
         }
         return _loc7_;
      }
      
      public function writeStringToProxy(param1:String, param2:String) : Boolean
      {
         var _loc3_:class_25 = null;
         var _loc4_:ByteArray = null;
         try
         {
            _loc3_ = class_23.instance.fileProxy;
            if(_loc3_)
            {
               _loc4_ = new ByteArray();
               _loc4_.writeUTFBytes(param2);
               _loc3_.writeCache(param1,_loc4_);
               return true;
            }
            return false;
         }
         catch(e:Error)
         {
            class_21.log("Caught error when writing String (" + param1 + ") to IFileProxy: " + e.toString());
            var _loc8_:Boolean = false;
         }
         return _loc8_;
      }
      
      private function errorInLoadingProcess(param1:class_54 = null) : void
      {
         var _loc2_:class_47 = class_47(param1.target);
         error("Failed to download library \"" + _loc2_.url + "\" HTTP status " + param1.status + " bytes loaded " + param1.bytesLoaded + "/" + param1.bytesTotal + " : " + _loc2_.getLastErrorMessage(),true,2);
         if(!disposed)
         {
            updateLoadingProcess(param1);
         }
      }
      
      private function finalizeLoadingEventDelegate() : void
      {
         if(_loadingEventDelegate != null)
         {
            _loadingEventDelegate.dispatchEvent(new Event("complete"));
            _loadingEventDelegate = null;
         }
      }
      
      private function updateLoadingProgress(param1:class_54 = null) : void
      {
         var _loc2_:class_47 = null;
         if(_loadingEventDelegate != null)
         {
            _loc2_ = param1.target as class_47;
            _loadingEventDelegate.dispatchEvent(new LibraryProgressEvent(_loc2_.url,param1.bytesLoaded,param1.bytesTotal,_loc2_.elapsedTime));
         }
      }
      
      private function updateLoadingProcess(param1:class_54 = null) : void
      {
         var _loc2_:class_47 = null;
         var _loc3_:String = null;
         if(param1 != null)
         {
            if(param1.type == "LIBRARY_LOADER_EVENT_COMPLETE" || param1.type == "LIBRARY_LOADER_EVENT_ERROR")
            {
               _loc2_ = param1.target as class_47;
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",updateLoadingProcess);
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",errorInLoadingProcess);
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_PROGRESS",updateLoadingProgress);
               _loc3_ = _loc2_.url;
               debug("Loading library \"" + _loc3_ + "\" " + (param1.type == "LIBRARY_LOADER_EVENT_COMPLETE" ? "ready" : "failed\n" + _loc2_.getLastErrorMessage()));
               _loc2_.dispose();
               if(!disposed)
               {
                  if(_loadingEventDelegate != null)
                  {
                     _loadingEventDelegate.dispatchEvent(new LibraryProgressEvent(_loc2_.url,_numberOfFilesInConfig - var_736.length,_numberOfFilesInConfig,_loc2_.elapsedTime));
                  }
               }
            }
         }
         if(!disposed)
         {
            if(var_736.length == 0)
            {
               finalizeLoadingEventDelegate();
               debug("All libraries loaded, Core is now running");
            }
         }
      }
      
      override public function registerUpdateReceiver(param1:class_31, param2:uint) : void
      {
         removeUpdateReceiver(param1);
         param2 = uint(param2 >= 3 ? 3 - 1 : param2);
         var _loc3_:int = int(var_475 ? 2 : var_2654 & 0x0F);
         if(_loc3_ == 4)
         {
            var_580[param2].push(new UpdateDelegate(param1,this,param2));
         }
         else
         {
            var_580[param2].push(param1);
         }
      }
      
      override public function removeUpdateReceiver(param1:class_31) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         if(disposed)
         {
            return;
         }
         var _loc3_:int = int(var_475 ? 2 : var_2654 & 0x0F);
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc4_ = var_580[_loc6_] as Array;
            if(_loc3_ == 4)
            {
               for each(var _loc2_ in _loc4_)
               {
                  if(_loc2_.receiver == param1)
                  {
                     _loc2_.dispose();
                     return;
                  }
               }
            }
            else
            {
               _loc5_ = int(_loc4_.indexOf(param1));
               if(_loc5_ > -1)
               {
                  _loc4_[_loc5_] = null;
                  return;
               }
            }
            _loc6_++;
         }
      }
      
      public function hibernate(param1:int, param2:int = 1) : void
      {
         if(!hibernating)
         {
            class_504.stop();
            _hibernationLevel = param1;
            _hibernationUpdateFrequency = 1000 / param2;
         }
      }
      
      public function resume() : void
      {
         if(hibernating)
         {
            class_504.start();
            _hibernationLevel = -1;
         }
      }
      
      private function get hibernating() : Boolean
      {
         return _hibernationLevel > -1;
      }
      
      private function get maxPriority() : uint
      {
         return hibernating ? _hibernationLevel + 1 : 3;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(_rebootOnNextFrame)
         {
            var_727.removeEventListener("enterFrame",onEnterFrame);
            _rebootOnNextFrame = false;
            events.dispatchEvent(new Event("COMPONENT_EVENT_REBOOT"));
            return;
         }
         var _loc3_:uint = uint(getTimer());
         var _loc2_:uint = _loc3_ - _lastUpdateTimeMs;
         if(!hibernating || _loc2_ > _hibernationUpdateFrequency)
         {
            var_243(_loc3_,_loc2_);
            _lastUpdateTimeMs = _loc3_;
         }
      }
      
      private function simpleFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:class_31 = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _loc7_ = 0;
         while(true)
         {
            if(_loc7_ >= maxPriority)
            {
               return;
            }
            var_1292[_loc7_] = 0;
            _loc4_ = var_580[_loc7_];
            _loc6_ = 0;
            _loc5_ = _loc4_.length;
            while(_loc6_ != _loc5_)
            {
               _loc3_ = class_31(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  try
                  {
                     _loc3_.update(param2);
                  }
                  catch(e:Error)
                  {
                     class_21.log(e.getStackTrace());
                     if(error("Error in update receiver \"" + getQualifiedClassName(_loc3_) + "\": " + e.message,true,e.errorID,e))
                     {
                        break;
                     }
                  }
                  _loc6_++;
               }
            }
            _loc7_++;
         }
      }
      
      private function complexFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc10_:Boolean = false;
         var _loc5_:* = 0;
         var _loc8_:uint = 1000 / var_727.stage.frameRate;
         _loc11_ = 0;
         while(_loc11_ < maxPriority)
         {
            _loc5_ = uint(getTimer());
            _loc10_ = false;
            if(_loc5_ - param1 > _loc8_)
            {
               if(var_1292[_loc11_] < _loc11_)
               {
                  var_1292[_loc11_]++;
                  _loc10_ = true;
               }
            }
            if(!_loc10_)
            {
               var_1292[_loc11_] = 0;
               var _loc6_:Array = var_580[_loc11_];
               var _loc9_:uint = 0;
               var _loc7_:uint = uint(null.length);
            }
            _loc11_++;
         }
      }
      
      private function profilerFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:class_31 = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var_475.start();
         _loc7_ = 0;
         while(true)
         {
            if(_loc7_ >= maxPriority)
            {
               var_475.stop();
               return;
            }
            var_1292[_loc7_] = 0;
            _loc4_ = var_580[_loc7_];
            _loc6_ = 0;
            _loc5_ = _loc4_.length;
            while(_loc6_ != _loc5_)
            {
               _loc3_ = class_31(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  try
                  {
                     var_475.update(_loc3_,param2);
                  }
                  catch(e:Error)
                  {
                     if(error("Error in update receiver \"" + getQualifiedClassName(_loc3_) + "\": " + e.message,true,e.errorID,e))
                     {
                        break;
                     }
                  }
                  _loc6_++;
               }
            }
            _loc7_++;
         }
      }
      
      private function experimentalFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc3_ = var_580[_loc5_];
            _loc4_ = _loc3_.length - 1;
            while(_loc4_ > -1)
            {
               if(_loc3_[_loc4_].disposed)
               {
                  _loc3_.splice(_loc4_,1);
               }
               _loc4_--;
            }
            _loc5_++;
         }
      }
      
      private function debugFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:class_31 = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < maxPriority)
         {
            var_1292[_loc7_] = 0;
            _loc4_ = var_580[_loc7_];
            _loc6_ = 0;
            _loc5_ = _loc4_.length;
            while(_loc6_ != _loc5_)
            {
               _loc3_ = class_31(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  try
                  {
                     _loc3_.update(param2);
                  }
                  catch(e:Error)
                  {
                     error("Error in update receiver \"" + getQualifiedClassName(_loc3_) + "\": " + e,false,e.errorID,e);
                  }
                  _loc6_++;
               }
            }
            _loc7_++;
         }
      }
      
      public function setProfilerMode(param1:Boolean) : void
      {
         if(!param1)
         {
            detachComponent(var_475);
            switch(var_2654 & 0x0F)
            {
               case 0:
                  var_243 = simpleFrameUpdateHandler;
                  break;
               case 1:
                  var_243 = complexFrameUpdateHandler;
                  break;
               case 4:
                  var_243 = experimentalFrameUpdateHandler;
                  var _loc5_:int = 0;
                  var _loc3_:Array = var_580[0];
                  var _loc4_:int = null.length - 1;
                  while(true)
                  {
                     var _loc2_:Object = null[0];
                     if(null is class_31)
                     {
                        null[0] = new UpdateDelegate(class_31(null),this,0);
                     }
                     _loc4_--;
                  }
                  break;
               default:
                  var_243 = debugFrameUpdateHandler;
            }
            return;
         }
         var_243 = profilerFrameUpdateHandler;
         if(!var_475 || var_475.disposed)
         {
            var_475 = new Profiler(this);
         }
         attachComponent(var_475,[new IIDProfiler()]);
         _loc5_ = 0;
         _loc3_ = var_580[0];
         _loc4_ = null.length - 1;
         while(true)
         {
            _loc2_ = null[0];
            if(null is UpdateDelegate)
            {
               null[0] = UpdateDelegate(null).receiver;
               UpdateDelegate(null).dispose();
            }
            _loc4_--;
         }
      }
      
      public function set errorLogger(param1:class_22) : void
      {
         if(var_3032 != null)
         {
            var_3032.errorLogger = param1;
         }
      }
      
      public function reboot() : void
      {
         _rebootOnNextFrame = true;
      }
   }
}

import flash.events.Event;
import flash.utils.getQualifiedClassName;
import flash.utils.getTimer;

class UpdateDelegate implements class_13
{
   
   private var _receiver:class_31;
   
   private var _context:class_15;
   
   private var _priority:int;
   
   private var _lastUpdateTimeMs:uint;
   
   private var _framesSkipped:uint = 0;
   
   public function UpdateDelegate(param1:class_31, param2:class_15, param3:int)
   {
      super();
      if(param2 && param1)
      {
         _receiver = param1;
         _context = param2;
         _priority = param3;
         param2.displayObjectContainer.stage.addEventListener(_priority == 0 ? "exitFrame" : "enterFrame",onFrameUpdate);
         _lastUpdateTimeMs = getTimer();
      }
   }
   
   public function get priority() : int
   {
      return _priority;
   }
   
   public function get receiver() : class_31
   {
      return _receiver;
   }
   
   public function get disposed() : Boolean
   {
      return _receiver ? _receiver.disposed : true;
   }
   
   public function dispose() : void
   {
      if(_receiver)
      {
         _receiver = null;
         _context.displayObjectContainer.stage.removeEventListener(_priority == 0 ? "exitFrame" : "enterFrame",onFrameUpdate);
         _context = null;
      }
   }
   
   private function onFrameUpdate(param1:Event) : void
   {
      var _loc2_:* = 0;
      if(!disposed)
      {
         _loc2_ = uint(getTimer());
         var _loc3_:uint = _loc2_ - _lastUpdateTimeMs;
         _lastUpdateTimeMs = _loc2_;
         if(_priority > 0 && _framesSkipped < _priority)
         {
            if(_loc3_ > 1000 / _context.displayObjectContainer.stage.frameRate)
            {
               _framesSkipped = Number(_framesSkipped) + 1;
               return;
            }
         }
         _framesSkipped = 0;
         try
         {
            _receiver.update(_loc3_);
         }
         catch(e:Error)
         {
            _context.error("Error in update receiver \"" + getQualifiedClassName(_receiver) + "\": " + e.message,true,e.errorID,e);
         }
      }
   }
}
