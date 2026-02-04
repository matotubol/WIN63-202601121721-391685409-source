package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.RegionController;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.enum.*;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.graphics.class_1770;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MouseEventProcessor implements IEventProcessor, class_13
   {
      
      protected static var var_816:Array;
      
      protected static var var_728:Array;
      
      protected static var GLOBAL_POINT:Point = new Point();
      
      protected var var_1257:Point;
      
      protected var var_225:WindowController;
      
      protected var var_395:WindowController;
      
      protected var var_927:WindowController;
      
      protected var var_163:WindowController;
      
      protected var var_303:class_1770;
      
      protected var var_185:class_2052;
      
      protected var _eventTrackers:Vector.<IInputEventTracker>;
      
      private var _disposed:Boolean = false;
      
      public function MouseEventProcessor()
      {
         super();
         var_1257 = new Point();
         if(var_816 == null)
         {
            var_816 = [];
            var_816[0] = 2;
            var_816[1] = 0;
            var_816[2] = 2;
            var_816[3] = 2;
            var_816[4] = 2;
            var_816[5] = 0;
            var_816[6] = 2;
         }
         if(var_728 == null)
         {
            var_728 = [];
            var_728[0] = 1;
            var_728[1] = 2;
            var_728[2] = 4;
            var_728[3] = 64;
            var_728[4] = 8;
            var_728[5] = 16;
            var_728[6] = 32;
         }
      }
      
      public static function setMouseCursorByState(param1:uint, param2:uint) : void
      {
         var _loc3_:int = int(var_728.indexOf(param1));
         if(_loc3_ > -1)
         {
            var_816[_loc3_] = param2;
         }
      }
      
      public static function getMouseCursorByState(param1:uint) : uint
      {
         var _loc2_:uint = var_728.length;
         while(_loc2_-- > 0)
         {
            if((param1 & var_728[_loc2_]) > 0)
            {
               return var_816[_loc2_];
            }
         }
         return 0;
      }
      
      protected static function convertMouseEventType(param1:MouseEvent, param2:class_1741, param3:class_1741, param4:String = null) : WindowMouseEvent
      {
         var _loc6_:String = null;
         var _loc8_:Point = new Point(param1.stageX,param1.stageY);
         param2.convertPointFromGlobalToLocalSpace(_loc8_);
         var _loc5_:String;
         switch(_loc5_ = param4 == null ? param1.type : param4)
         {
            case "mouseMove":
               _loc6_ = "WME_MOVE";
               break;
            case "mouseOver":
               _loc6_ = "WME_OVER";
               break;
            case "mouseOut":
               _loc6_ = "WME_OUT";
               break;
            case "rollOut":
               _loc6_ = "WME_ROLL_OUT";
               break;
            case "rollOver":
               _loc6_ = "WME_ROLL_OVER";
               break;
            case "click":
               _loc6_ = "WME_CLICK";
               break;
            case "doubleClick":
               _loc6_ = "WME_DOUBLE_CLICK";
               break;
            case "mouseDown":
               _loc6_ = "WME_DOWN";
               break;
            case "mouseUp":
               var _loc7_:Boolean = _loc8_.x > -1 && _loc8_.y > -1 && _loc8_.x < param2.width && _loc8_.y < param2.height;
               _loc6_ = _loc7_ ? "WME_UP" : "WME_UP_OUTSIDE";
               break;
            case "mouseWheel":
               _loc6_ = "WME_WHEEL";
               break;
            default:
               _loc6_ = "";
         }
         return WindowMouseEvent.allocate(_loc6_,param2,param3,_loc8_.x,_loc8_.y,param1.stageX,param1.stageY,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown,param1.delta);
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
         }
      }
      
      public function process(param1:EventProcessorState, param2:IEventQueue) : void
      {
         if(param2.length == 0)
         {
            return;
         }
         var_185 = param1.desktop;
         var_163 = param1.var_2974 as WindowController;
         var_225 = param1.lastClickTarget as WindowController;
         var_395 = param1.lastMouseDownTarget as WindowController;
         var_927 = param1.var_4295 as WindowController;
         var_303 = param1.renderer;
         _eventTrackers = param1.eventTrackers;
         param2.begin();
         var_1257.x = -1;
         var_1257.y = -1;
         var _loc12_:int = 0;
         while(true)
         {
            var _loc10_:MouseEvent = param2.next() as MouseEvent;
            if(_loc10_ == null)
            {
               break;
            }
            if(null.stageX != var_1257.x || null.stageY != var_1257.y)
            {
               var_1257.x = null.stageX;
               var_1257.y = null.stageY;
               var _loc4_:Array = [];
               var_185.groupParameterFilteredChildrenUnderPoint(var_1257,null,1);
            }
            var _loc7_:int = 0;
            if(_loc7_ == 0)
            {
               switch(null.type)
               {
                  case "mouseMove":
                     if(var_163 != var_185 && !var_163.disposed)
                     {
                        var_163.getGlobalPosition(GLOBAL_POINT);
                        var _loc8_:class_1758 = WindowMouseEvent.allocate("WME_OUT",var_163,null,null.stageX - GLOBAL_POINT.x,null.stageY - GLOBAL_POINT.y,null.stageX,null.stageY,null.altKey,null.ctrlKey,null.shiftKey,null.buttonDown,null.delta);
                        var_163.update(var_163,null);
                        var_163 = WindowController(var_185);
                        null.recycle();
                     }
                     break;
                  case "mouseDown":
                     var _loc9_:class_1741 = var_185.getActiveWindow();
                     if(_loc9_)
                     {
                        null.deactivate();
                     }
               }
            }
            loop3:
            while(true)
            {
               if(null.type == "mouseUp" && var_395 != null && null.indexOf(var_395) == -1)
               {
                  _loc4_ = [];
                  null.push(var_395);
                  _loc7_++;
               }
               while(true)
               {
                  _loc7_--;
                  var _loc11_:WindowController = passMouseEvent(WindowController(null[0]),null);
                  if(_loc11_ != null && Boolean(null.visible))
                  {
                     break loop3;
                  }
               }
               break;
            }
            if(null.type == "mouseMove")
            {
               if(null != var_163)
               {
                  if(!var_163.disposed)
                  {
                     var_163.getGlobalPosition(GLOBAL_POINT);
                     _loc8_ = WindowMouseEvent.allocate("WME_OUT",var_163,null,null.stageX - GLOBAL_POINT.x,null.stageY - GLOBAL_POINT.y,null.stageX,null.stageY,null.altKey,null.ctrlKey,null.shiftKey,null.buttonDown,null.delta);
                     var_163.update(var_163,null);
                     null.recycle();
                  }
                  if(!null.disposed)
                  {
                     null.getGlobalPosition(GLOBAL_POINT);
                     _loc8_ = WindowMouseEvent.allocate("WME_OVER",null,null,null.stageX - GLOBAL_POINT.x,null.stageY - GLOBAL_POINT.y,null.stageX,null.stageY,null.altKey,null.ctrlKey,null.shiftKey,null.buttonDown,null.delta);
                     null.update(null,null);
                     null.recycle();
                  }
                  if(!null.disposed)
                  {
                     var_163 = null;
                  }
               }
            }
            if(null.type == "mouseDown")
            {
               if(var_927 != null && !var_927.disposed && null != var_927)
               {
                  var _loc5_:WindowMouseEvent = WindowMouseEvent.allocate("WME_CLICK_AWAY",var_927,null,NaN,NaN,null.stageX,null.stageY,null.altKey,null.ctrlKey,null.shiftKey,null.buttonDown,null.delta);
                  var_927.update(var_927,null);
                  null.recycle();
               }
               var_927 = null;
            }
            var _loc3_:class_1741 = null.parent;
            if(var_163 is IInteractiveWindow)
            {
               try
               {
                  var _loc6_:IInteractiveWindow = IInteractiveWindow(var_163);
                  if(_loc6_.interactiveCursorDisabled)
                  {
                     _loc12_ = 0;
                  }
                  else
                  {
                     _loc12_ = int(null.getMouseCursorByState(var_163.state));
                     if(_loc12_ == 0)
                     {
                        _loc12_ = int(getMouseCursorByState(var_163.state));
                     }
                  }
               }
               catch(e:Error)
               {
                  _loc12_ = 0;
               }
            }
            if(null != var_185)
            {
               null.stopPropagation();
               param2.remove();
            }
         }
         param2.end();
         MouseCursorControl.type = _loc12_;
         param1.desktop = var_185;
         param1.var_2974 = var_163;
         param1.lastClickTarget = var_225;
         param1.lastMouseDownTarget = var_395;
         param1.var_4295 = var_927;
         param1.renderer = var_303;
         param1.eventTrackers = _eventTrackers;
      }
      
      private function passMouseEvent(param1:WindowController, param2:MouseEvent, param3:Boolean = false) : WindowController
      {
         var _loc9_:BitmapData = null;
         var _loc6_:WindowMouseEvent = null;
         if(param1.disposed)
         {
            return null;
         }
         if(param1.testStateFlag(32) && param2.type == "mouseMove" && param1 is RegionController)
         {
            return param1;
         }
         if(param1.testStateFlag(32))
         {
            return null;
         }
         var _loc12_:Point = new Point(param2.stageX,param2.stageY);
         param1.convertPointFromGlobalToLocalSpace(_loc12_);
         if(param2.type == "mouseUp")
         {
            if(var_395 == null)
            {
               var_225 = null;
               return null;
            }
            if(param1 != var_395)
            {
               while(true)
               {
                  if(var_395 && !var_395.disposed)
                  {
                     var_395.update(var_395,convertMouseEventType(new MouseEvent("mouseUp",false,true,param2.localX,param2.localY,null,param2.ctrlKey,param2.altKey,param2.shiftKey,param2.buttonDown,param2.delta),var_395,param1));
                     var_225 = null;
                     if(param1.disposed)
                     {
                        return null;
                     }
                  }
               }
               addr00f6:
               if(param1.ignoreMouseEvents)
               {
                  return null;
               }
               _loc9_ = var_303.getDrawBufferForRenderable(param1);
               if(!param1.validateLocalPointIntersection(_loc12_,_loc9_))
               {
                  return null;
               }
               if(param1.testParamFlag(3))
               {
                  if(param1.parent != null)
                  {
                     return passMouseEvent(WindowController(param1.parent),param2);
                  }
               }
               if(!param3)
               {
                  switch(param2.type)
                  {
                     case "mouseDown":
                        var_225 = param1;
                        var_395 = param1;
                        break;
                     case "click":
                        if(var_225 != param1)
                        {
                           var_225 = null;
                           return null;
                        }
                        var_225 = null;
                        break;
                     case "doubleClick":
                        if(var_225 != param1)
                        {
                           var_225 = null;
                           return null;
                        }
                        var_225 = null;
                  }
               }
               var _loc11_:Array = [];
               if(param2.type == "doubleClick")
               {
                  _loc11_.push("click");
               }
               _loc11_.push(param2.type);
               var _loc4_:Boolean = false;
               for each(var _loc10_ in _loc11_)
               {
                  _loc6_ = convertMouseEventType(param2,param1,null,_loc10_);
                  if(param1.update(param1,_loc6_))
                  {
                     _loc4_ = true;
                  }
                  for each(var _loc8_ in _eventTrackers)
                  {
                     _loc8_.eventReceived(_loc6_,param1);
                  }
                  _loc6_.recycle();
               }
               if(!_loc4_ && !param3)
               {
                  if(param1.parent)
                  {
                     return passMouseEvent(WindowController(param1.parent),param2);
                  }
               }
               return param1;
            }
            var _loc7_:* = !param1.hitTestLocalPoint(_loc12_);
            var_395 = null;
         }
         §§goto(addr00f6);
      }
   }
}

