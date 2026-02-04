package com.sulake.core.window
{
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.localization.ILocalizable;
   import com.sulake.core.localization.class_26;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.components.DesktopController;
   import com.sulake.core.window.components.SubstituteParentController;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.graphics.IGraphicContextHost;
   import com.sulake.core.window.graphics.class_1770;
   import com.sulake.core.window.services.IInternalWindowServices;
   import com.sulake.core.window.services.ServiceManager;
   import com.sulake.core.window.utils.EventProcessorState;
   import com.sulake.core.window.utils.IEventProcessor;
   import com.sulake.core.window.utils.IEventQueue;
   import com.sulake.core.window.utils.MouseEventProcessor;
   import com.sulake.core.window.utils.MouseEventQueue;
   import com.sulake.core.window.utils.WindowParser;
   import com.sulake.core.window.utils.class_2782;
   import com.sulake.core.window.utils.tablet.TabletEventProcessor;
   import com.sulake.core.window.utils.tablet.TabletEventQueue;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class WindowContext implements class_1892, class_13, class_31
   {
      
      public static const INPUT_MODE_MOUSE:uint = 0;
      
      public static const INPUT_MODE_TOUCH:uint = 1;
      
      public static const ERROR_UNKNOWN:int = 0;
      
      public static const ERROR_INVALID_WINDOW:int = 1;
      
      public static const ERROR_WINDOW_NOT_FOUND:int = 2;
      
      public static const ERROR_WINDOW_ALREADY_EXISTS:int = 3;
      
      public static const ERROR_UNKNOWN_WINDOW_TYPE:int = 4;
      
      public static const ERROR_DURING_EVENT_HANDLING:int = 5;
      
      public static var inputEventQueue:IEventQueue;
      
      private static var inputEventProcessor:IEventProcessor;
      
      private static var inputModeFlag:uint = 0;
      
      private static var var_303:class_1770;
      
      private static var stage:Stage;
      
      public var inputEventTrackers:Vector.<IInputEventTracker>;
      
      private var _linkEventTrackers:Vector.<ILinkEventTracker>;
      
      private var var_4981:EventProcessorState;
      
      protected var _localization:class_26;
      
      protected var _rootDisplayObject:DisplayObjectContainer;
      
      protected var _throwErrors:Boolean = true;
      
      protected var _lastError:Error;
      
      protected var var_3304:int = -1;
      
      protected var var_1985:IInternalWindowServices;
      
      protected var var_2231:class_2782;
      
      protected var var_2687:class_36;
      
      protected var var_2939:class_35;
      
      protected var var_1716:IResourceManager;
      
      protected var var_185:class_2052;
      
      protected var var_2237:SubstituteParentController;
      
      private var _disposed:Boolean = false;
      
      private var var_413:Boolean = false;
      
      private var _rendering:Boolean = false;
      
      private var _name:String;
      
      private var var_637:class_16;
      
      public function WindowContext(param1:String, param2:class_1770, param3:class_36, param4:class_35, param5:IResourceManager, param6:class_26, param7:class_16, param8:DisplayObjectContainer, param9:Rectangle, param10:Vector.<ILinkEventTracker>)
      {
         super();
         _name = param1;
         var_303 = param2;
         _localization = param6;
         var_637 = param7;
         _rootDisplayObject = param8;
         var_1985 = new ServiceManager(this,param8);
         var_2687 = param3;
         var_2939 = param4;
         var_1716 = param5;
         var_2231 = new WindowParser(this);
         inputEventTrackers = new Vector.<IInputEventTracker>(0);
         _linkEventTrackers = param10;
         if(!stage)
         {
            if(_rootDisplayObject is Stage)
            {
               stage = _rootDisplayObject as Stage;
            }
            else if(_rootDisplayObject.stage)
            {
               stage = _rootDisplayObject.stage;
            }
         }
         Classes.init();
         if(param9 == null)
         {
            param9 = new Rectangle(0,0,800,600);
         }
         var_185 = new DesktopController("_CONTEXT_DESKTOP_" + _name,this,param9);
         var_185.limits.maxWidth = param9.width;
         var_185.limits.maxHeight = param9.height;
         _rootDisplayObject.addChild(var_185.getDisplayObject());
         _rootDisplayObject.doubleClickEnabled = true;
         _rootDisplayObject.addEventListener("resize",stageResizedHandler);
         var_4981 = new EventProcessorState(var_303,var_185,var_185,null,null,null,inputEventTrackers);
         inputMode = 0;
         var_2237 = new SubstituteParentController(this);
      }
      
      public static function get inputMode() : uint
      {
         return inputModeFlag;
      }
      
      public static function set inputMode(param1:uint) : void
      {
         if(inputEventQueue)
         {
            if(inputEventQueue is class_13)
            {
               class_13(inputEventQueue).dispose();
            }
         }
         if(inputEventProcessor)
         {
            if(inputEventProcessor is class_13)
            {
               class_13(inputEventProcessor).dispose();
            }
         }
         switch(param1)
         {
            case INPUT_MODE_MOUSE:
               inputEventQueue = new MouseEventQueue(stage);
               inputEventProcessor = new MouseEventProcessor();
               try
               {
                  break;
               }
               catch(e:Error)
               {
                  break;
               }
               break;
            case 1:
               inputEventQueue = new TabletEventQueue(stage);
               inputEventProcessor = new TabletEventProcessor();
               try
               {
                  break;
               }
               catch(e:Error)
               {
                  break;
               }
               break;
            default:
               inputMode = INPUT_MODE_MOUSE;
               throw new Error("Unknown input mode " + param1);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _rootDisplayObject.removeEventListener("resize",stageResizedHandler);
            _rootDisplayObject.removeChild(IGraphicContextHost(var_185).getGraphicContext(true) as DisplayObject);
            var_185.destroy();
            var_185 = null;
            var_2237.destroy();
            var_2237 = null;
            if(var_1985 is class_13)
            {
               class_13(var_1985).dispose();
            }
            var_1985 = null;
            var_2231.dispose();
            var_2231 = null;
            var_303 = null;
            _localization = null;
            _rootDisplayObject = null;
            var_2687 = null;
            var_2939 = null;
            var_1716 = null;
         }
      }
      
      public function getLastError() : Error
      {
         return _lastError;
      }
      
      public function getLastErrorCode() : int
      {
         return var_3304;
      }
      
      public function handleError(param1:int, param2:Error) : void
      {
         _lastError = param2;
         var_3304 = param1;
         if(_throwErrors)
         {
            throw param2;
         }
      }
      
      public function flushError() : void
      {
         _lastError = null;
         var_3304 = -1;
      }
      
      public function getWindowServices() : IInternalWindowServices
      {
         return var_1985;
      }
      
      public function getWindowParser() : class_2782
      {
         return var_2231;
      }
      
      public function getWindowFactory() : class_36
      {
         return var_2687;
      }
      
      public function getDesktopWindow() : class_2052
      {
         return var_185;
      }
      
      public function findWindowByName(param1:String) : class_1741
      {
         return var_185.findChildByName(param1);
      }
      
      public function findWindowByTag(param1:String) : class_1741
      {
         return var_185.findChildByTag(param1);
      }
      
      public function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         return var_185.groupChildrenWithTag(param1,param2,param3);
      }
      
      public function registerLocalizationListener(param1:String, param2:class_1741) : void
      {
         _localization.registerListener(param1,param2 as ILocalizable);
      }
      
      public function removeLocalizationListener(param1:String, param2:class_1741) : void
      {
         _localization.removeListener(param1,param2 as ILocalizable);
      }
      
      public function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:class_1741, param9:uint, param10:Array = null, param11:String = "", param12:Array = null) : class_1741
      {
         var _loc14_:class_1741 = null;
         var _loc13_:Class = Classes.getWindowClassByType(param3);
         if(_loc13_ == null)
         {
            handleError(4,new Error("Failed to solve implementation for window \"" + param1 + "\"!"));
            return null;
         }
         if(param8 == null)
         {
            if(param5 & 0x10)
            {
               param8 = var_2237;
            }
         }
         _loc14_ = new _loc13_(param1,param3,param4,param5,this,param6,param8 ?? var_185,param7,param10,param12,param9);
         _loc14_.dynamicStyle = param11;
         if(param2 && param2.length)
         {
            _loc14_.caption = param2;
         }
         return _loc14_;
      }
      
      public function destroy(param1:class_1741) : Boolean
      {
         if(param1 == var_185)
         {
            var_185 = null;
         }
         if(param1.state != 1073741824)
         {
            param1.destroy();
         }
         return true;
      }
      
      public function invalidate(param1:class_1741, param2:Rectangle, param3:uint) : void
      {
         if(!disposed)
         {
            var_303.addToRenderQueue(param1,param2,param3);
         }
      }
      
      public function update(param1:uint) : void
      {
         var_413 = true;
         if(_lastError)
         {
            var _loc2_:Error = _lastError;
            _lastError = null;
            throw null;
         }
         inputEventProcessor.process(var_4981,inputEventQueue);
         var_413 = false;
      }
      
      public function render(param1:uint) : void
      {
         _rendering = true;
         var_303.render();
         _rendering = false;
      }
      
      private function stageResizedHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(var_185 != null && !var_185.disposed)
         {
            if(_rootDisplayObject is Stage)
            {
               _loc2_ = int(Stage(_rootDisplayObject).stageWidth);
               _loc3_ = int(Stage(_rootDisplayObject).stageHeight);
            }
            else
            {
               _loc2_ = _rootDisplayObject.width;
               _loc3_ = _rootDisplayObject.height;
            }
            if(_loc2_ >= 10 && _loc3_ >= 10)
            {
               var_185.limits.maxWidth = _loc2_;
               var_185.limits.maxHeight = _loc3_;
               var_185.width = _loc2_;
               var_185.height = _loc3_;
            }
         }
      }
      
      public function addMouseEventTracker(param1:IInputEventTracker) : void
      {
         if(inputEventTrackers.indexOf(param1) < 0)
         {
            inputEventTrackers.push(param1);
         }
      }
      
      public function removeMouseEventTracker(param1:IInputEventTracker) : void
      {
         var _loc2_:int = int(inputEventTrackers.indexOf(param1));
         if(_loc2_ > -1)
         {
            inputEventTrackers.splice(_loc2_,1);
         }
      }
      
      public function getResourceManager() : IResourceManager
      {
         return var_1716;
      }
      
      public function getWidgetFactory() : class_35
      {
         return var_2939;
      }
      
      public function get linkEventTrackers() : Vector.<ILinkEventTracker>
      {
         return _linkEventTrackers;
      }
   }
}

