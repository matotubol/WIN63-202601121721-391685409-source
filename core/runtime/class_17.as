package com.sulake.core.runtime
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.runtime.events.LockEvent;
   import com.sulake.core.runtime.exceptions.*;
   import com.sulake.core.utils.ClassUtils;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [SecureSWF(rename="true")]
   public class class_17 implements IUnknown, class_16
   {
      
      public static const COMPONENT_EVENT_RUNNING:String = "COMPONENT_EVENT_RUNNING";
      
      public static const COMPONENT_EVENT_DISPOSING:String = "COMPONENT_EVENT_DISPOSING";
      
      public static const COMPONENT_EVENT_WARNING:String = "COMPONENT_EVENT_WARNING";
      
      public static const COMPONENT_EVENT_ERROR:String = "COMPONENT_EVENT_ERROR";
      
      public static const COMPONENT_EVENT_DEBUG:String = "COMPONENT_EVENT_DEBUG";
      
      public static const COMPONENT_EVENT_UNLOCKED:String = "COMPONENT_EVENT_UNLOCKED";
      
      public static const COMPONENT_EVENT_REBOOT:String = "COMPONENT_EVENT_REBOOT";
      
      protected static const INTERNAL_EVENT_UNLOCKED:String = "_INTERNAL_EVENT_UNLOCKED";
      
      public static const COMPONENT_FLAG_NULL:uint = 0;
      
      public static const COMPONENT_FLAG_INTERFACE:uint = 1;
      
      public static const COMPONENT_FLAG_CONTEXT:uint = 2;
      
      public static const COMPONENT_FLAG_DISPOSABLE:uint = 4;
      
      protected var var_1032:uint = 0;
      
      protected var _lastError:String = "";
      
      protected var var_4084:String = "";
      
      protected var var_3444:String = "";
      
      private var _assets:class_40;
      
      private var name_1:EventDispatcherWrapper;
      
      private var var_2654:uint;
      
      private var var_920:InterfaceStructList;
      
      private var _context:class_15 = null;
      
      private var _disposed:Boolean = false;
      
      private var var_1613:Boolean = false;
      
      private var var_1499:int = 1;
      
      private var var_1804:Vector.<String>;
      
      private var var_2545:Vector.<Function> = new Vector.<Function>(0);
      
      public function class_17(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super();
         var_2654 = param2;
         var_920 = new InterfaceStructList();
         name_1 = new EventDispatcherWrapper();
         _context = param1;
         _assets = param3 ?? new AssetLibrary("_internal_asset_library");
         if(_context == null)
         {
            throw new InvalidComponentException("IContext not provided to Component\'s constructor!");
         }
         if(dependencies.length > 0)
         {
            lock();
         }
         var_1804 = new Vector.<String>(0);
         for each(var _loc4_ in dependencies)
         {
            if(_loc4_.isRequired)
            {
               var_1804.push(ClassUtils.getSimpleQualifiedClassName(_loc4_.identifier));
            }
            injectDependency(_loc4_.identifier,_loc4_.dependencySetter,_loc4_.isRequired,_loc4_.eventListeners);
         }
         allDependenciesRequested();
      }
      
      public static function getInterfaceStructList(param1:class_17) : InterfaceStructList
      {
         return param1.var_920;
      }
      
      public function get locked() : Boolean
      {
         return var_1613;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get context() : class_15
      {
         return _context;
      }
      
      public function get events() : IEventDispatcher
      {
         return name_1;
      }
      
      public function get assets() : class_40
      {
         return _assets;
      }
      
      private function injectDependency(param1:IID, param2:Function, param3:Boolean, param4:Array) : void
      {
         var identifier:IID = param1;
         var dependencySetter:Function = param2;
         var isRequired:Boolean = param3;
         var eventListeners:Array = param4;
         if(isRequired)
         {
            var_1499 = var_1499 + 1;
         }
         queueInterface(identifier,(function(param1:Function, param2:Boolean, param3:Array, param4:String):Function
         {
            var setter:Function = param1;
            var required:Boolean = param2;
            var listeners:Array = param3;
            var componentName:String = param4;
            return function(param1:IID, param2:IUnknown):void
            {
               var eventDispatcher:IEventDispatcher;
               var listener:Object;
               var identifier:IID = param1;
               var unknown:IUnknown = param2;
               if(disposed)
               {
                  return;
               }
               if(setter != null)
               {
                  setter(unknown);
               }
               if(listeners != null)
               {
                  eventDispatcher = class_17(unknown).events;
                  for each(listener in listeners)
                  {
                     eventDispatcher.addEventListener(listener.type,listener.callback);
                  }
               }
               var_2545.push((function(param1:IID, param2:IUnknown):Function
               {
                  var iid:IID = param1;
                  var component:IUnknown = param2;
                  return function():void
                  {
                     var _loc2_:IEventDispatcher = null;
                     if(listeners != null)
                     {
                        _loc2_ = class_17(component).events;
                        if(_loc2_ != null)
                        {
                           for each(var _loc1_ in listeners)
                           {
                              _loc2_.removeEventListener(_loc1_.type,_loc1_.callback);
                           }
                        }
                     }
                     if(setter != null)
                     {
                        setter(null);
                     }
                     component.release(iid);
                  };
               })(identifier,unknown));
               if(required)
               {
                  allDependenciesRequested(ClassUtils.getSimpleQualifiedClassName(identifier));
               }
            };
         })(dependencySetter,isRequired,eventListeners,ClassUtils.getSimpleQualifiedClassName(this)));
      }
      
      private function allDependenciesRequested(param1:String = "") : void
      {
         var_1499 = var_1499 - 1;
         if(param1 != "" && var_1804.indexOf(param1) > -1)
         {
            var_1804.splice(var_1804.indexOf(param1),1);
         }
         if(var_1499 == 0)
         {
            initComponent();
            unlock();
         }
      }
      
      protected function get allRequiredDependenciesInjected() : Boolean
      {
         return var_1499 == 0;
      }
      
      protected function get dependencies() : Vector.<ComponentDependency>
      {
         return new Vector.<ComponentDependency>(0);
      }
      
      protected function initComponent() : void
      {
      }
      
      public function queueInterface(param1:IID, param2:Function = null) : IUnknown
      {
         var _loc3_:InterfaceStruct = var_920.getStructByInterface(param1);
         if(_loc3_ == null)
         {
            return _context.queueInterface(param1,param2);
         }
         if(_disposed)
         {
            throw new ComponentDisposedException("Failed to queue interface trough disposed Component \"" + ClassUtils.getSimpleQualifiedClassName(this) + "\"!");
         }
         if(var_1613)
         {
            return null;
         }
         _loc3_.reserve();
         var _loc4_:IUnknown = _loc3_.unknown as IUnknown;
         if(param2 != null)
         {
            param2(param1,_loc4_);
         }
         return _loc4_;
      }
      
      public function release(param1:IID) : uint
      {
         if(_disposed)
         {
            return 0;
         }
         var _loc2_:InterfaceStruct = var_920.getStructByInterface(param1);
         if(_loc2_ == null)
         {
            _lastError = "Attempting to release unknown interface:" + param1 + "!";
            throw new Error(_lastError);
         }
         var _loc3_:uint = _loc2_.release();
         if(var_2654 & 4)
         {
            if(_loc3_ == 0)
            {
               if(var_920.getTotalReferenceCount() == 0)
               {
                  _context.detachComponent(this);
                  this.dispose();
               }
            }
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            for each(var _loc1_ in var_2545)
            {
               _loc1_();
            }
            var_2545 = null;
            name_1.dispatchEvent(new Event("COMPONENT_EVENT_DISPOSING"));
            name_1 = null;
            var_920.dispose();
            var_920 = null;
            _assets.dispose();
            _assets = null;
            _context = null;
            var_1032 = 0;
            _disposed = true;
         }
      }
      
      public function purge() : void
      {
      }
      
      final protected function lock() : void
      {
         if(!var_1613)
         {
            var_1613 = true;
         }
      }
      
      final protected function unlock() : void
      {
         if(var_1613)
         {
            var_1613 = false;
            name_1.dispatchEvent(new LockEvent("_INTERNAL_EVENT_UNLOCKED",this));
         }
      }
      
      public function toString() : String
      {
         return "[component " + ClassUtils.getSimpleQualifiedClassName(this) + " refs: " + var_1032 + "]";
      }
      
      public function toXMLString(param1:uint = 0) : String
      {
         var _loc7_:* = 0;
         var _loc3_:InterfaceStruct = null;
         var _loc8_:* = 0;
         var _loc4_:String = "";
         _loc7_ = 0;
         while(_loc7_ < param1)
         {
            _loc4_ += "\t";
            _loc7_++;
         }
         var _loc5_:String = getQualifiedClassName(this);
         var _loc2_:String = "";
         _loc2_ += _loc4_ + "<component class=\"" + _loc5_ + "\">\n";
         var _loc6_:uint = var_920.length;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc3_ = var_920.getStructByIndex(_loc8_);
            _loc2_ += _loc4_ + "\t<interface iid=\"" + _loc3_.iis + "\" refs=\"" + _loc3_.references + "\"/>\n";
            _loc8_++;
         }
         return _loc2_ + (_loc4_ + "</component>\n");
      }
      
      public function get requiredDependencyIids() : Vector.<String>
      {
         return var_1804;
      }
      
      public function registerUpdateReceiver(param1:class_31, param2:uint) : void
      {
         if(!_disposed)
         {
            _context.registerUpdateReceiver(param1,param2);
         }
      }
      
      public function removeUpdateReceiver(param1:class_31) : void
      {
         if(!_disposed)
         {
            _context.removeUpdateReceiver(param1);
         }
      }
      
      public function get flags() : uint
      {
         return var_2654;
      }
      
      public function propertyExists(param1:String) : Boolean
      {
         return _context.configuration ? _context.configuration.propertyExists(param1) : false;
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return _context.configuration ? _context.configuration.getProperty(param1,param2) : "";
      }
      
      public function setProperty(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(_context.configuration)
         {
            _context.configuration.setProperty(param1,param2,param3,param4);
         }
      }
      
      public function getBoolean(param1:String) : Boolean
      {
         return _context.configuration ? _context.configuration.getBoolean(param1) : false;
      }
      
      public function getInteger(param1:String, param2:int) : int
      {
         return _context.configuration ? _context.configuration.getInteger(param1,param2) : 0;
      }
      
      public function interpolate(param1:String) : String
      {
         return _context.configuration ? _context.configuration.interpolate(param1) : "";
      }
      
      public function updateUrlProtocol(param1:String) : String
      {
         return _context.configuration ? _context.configuration.updateUrlProtocol(param1) : "";
      }
   }
}

