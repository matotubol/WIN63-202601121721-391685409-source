package com.sulake.core.window.services
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IToolTipWindow;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class WindowToolTipAgent extends WindowMouseOperator implements IToolTipAgentService
   {
      
      protected var var_807:String;
      
      protected var var_226:IToolTipWindow;
      
      protected var var_695:Timer;
      
      protected var _toolTipOffset:Point = new Point(20,20);
      
      protected var _pointerOffset:Point = new Point();
      
      protected var var_2097:uint = 500;
      
      public function WindowToolTipAgent(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function begin(param1:class_1741, param2:uint = 0) : class_1741
      {
         if(param1 && !param1.disposed)
         {
            if(param1 is IInteractiveWindow)
            {
               var_807 = IInteractiveWindow(param1).toolTipCaption;
               var_2097 = IInteractiveWindow(param1).toolTipDelay;
            }
            else
            {
               var_807 = param1.caption;
               var_2097 = 500;
            }
            _mouse.x = var_134.mouseX;
            _mouse.y = var_134.mouseY;
            getMousePositionRelativeTo(param1,_mouse,_pointerOffset);
            if(var_695 == null)
            {
               var_695 = new Timer(var_2097,1);
               var_695.addEventListener("timer",showToolTip);
            }
            var_695.reset();
            var_695.start();
         }
         return super.begin(param1,param2);
      }
      
      override public function end(param1:class_1741) : class_1741
      {
         if(var_695 != null)
         {
            var_695.stop();
            var_695.removeEventListener("timer",showToolTip);
            var_695 = null;
         }
         hideToolTip();
         return super.end(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         if(_window && !_window.disposed)
         {
            _mouse.x = param1;
            _mouse.y = param2;
            getMousePositionRelativeTo(_window,_mouse,_pointerOffset);
            if(var_226 != null && !var_226.disposed)
            {
               var_226.x = param1 + _toolTipOffset.x;
               var_226.y = param2 + _toolTipOffset.y;
            }
         }
      }
      
      protected function showToolTip(param1:TimerEvent) : void
      {
         if(var_695 != null)
         {
            var_695.reset();
         }
         if(_window && !_window.disposed)
         {
            if(_window is IInteractiveWindow)
            {
               var_807 = IInteractiveWindow(_window).toolTipCaption;
            }
            else
            {
               var_807 = _window.caption;
            }
            if(var_226 == null || Boolean(var_226.disposed))
            {
               var_226 = _window.context.create(_window.name + "::ToolTip",var_807,8,_window.style,0x20 | 0,null,null,null,0,null,null) as IToolTipWindow;
            }
            var _loc2_:Point = new Point();
            _window.getGlobalPosition(null);
            var_226.x = null.x + _pointerOffset.x + _toolTipOffset.x;
            var_226.y = null.y + _pointerOffset.y + _toolTipOffset.y;
            var_226.visible = var_226.caption.length > 0;
         }
      }
      
      protected function hideToolTip() : void
      {
         if(var_226 != null && !var_226.disposed)
         {
            var_226.destroy();
            var_226 = null;
         }
      }
      
      public function updateCaption(param1:class_1741) : void
      {
         var _loc2_:String = null;
         if(param1 == null || Boolean(param1.disposed) || var_226 == null || Boolean(var_226.disposed))
         {
            return;
         }
         if(param1 is IInteractiveWindow)
         {
            _loc2_ = IInteractiveWindow(param1).toolTipCaption;
         }
         else
         {
            _loc2_ = param1.caption;
         }
         if(_loc2_ != var_807)
         {
            var_807 = _loc2_;
            if(_loc2_ == null || _loc2_.length == 0)
            {
               var_226.visible = false;
            }
            else
            {
               var_226.caption = _loc2_;
               var_226.visible = true;
            }
         }
      }
   }
}

