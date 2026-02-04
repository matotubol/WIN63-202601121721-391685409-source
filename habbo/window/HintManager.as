package com.sulake.habbo.window
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.motion.Callback;
   import com.sulake.core.window.motion.Combo;
   import com.sulake.core.window.motion.EaseOut;
   import com.sulake.core.window.motion.Motion;
   import com.sulake.core.window.motion.MoveTo;
   import com.sulake.core.window.motion.Queue;
   import com.sulake.core.window.motion.ResizeTo;
   import com.sulake.core.window.motion.class_2939;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class HintManager implements class_13, class_31
   {
      
      private static const const_491:int = 10;
      
      private static const const_409:int = 400;
      
      private static const const_527:int = 15;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _registeredWindows:Dictionary = new Dictionary();
      
      private var _activeHint:HintTarget;
      
      private var _hint:IStaticBitmapWrapperWindow;
      
      private var var_5208:Rectangle;
      
      private var var_2535:Rectangle;
      
      public function HintManager(param1:HabboWindowManagerComponent)
      {
         super();
         _windowManager = param1;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hideHint();
         _activeHint = null;
         _registeredWindows = null;
         _windowManager = null;
      }
      
      public function get disposed() : Boolean
      {
         return _windowManager == null;
      }
      
      public function registerWindow(param1:String, param2:class_1741, param3:int) : void
      {
         if(_registeredWindows[param1] != null)
         {
            unregisterWindow(param1);
         }
         _registeredWindows[param1] = new HintTarget(param2,param1,param3);
      }
      
      public function unregisterWindow(param1:String) : void
      {
         if(activeKey == param1)
         {
            hideHint();
         }
         delete _registeredWindows[param1];
      }
      
      public function showHint(param1:String, param2:Rectangle = null) : void
      {
         var _loc3_:HintTarget = _registeredWindows[param1];
         if(_loc3_ != null && _loc3_.window != null && param1 != activeKey)
         {
            hideHint();
            _hint = _loc3_.window.context.create("","",23,0,0,null,null,null,0) as IStaticBitmapWrapperWindow;
            _hint.fitSizeToContents = true;
            _hint.visible = false;
            switch(_loc3_.style - 1)
            {
               case 0:
                  _hint.assetUri = "common_green_arrow_vertical";
                  break;
               default:
                  _hint.assetUri = "common_green_arrow_horizontal";
            }
            _activeHint = _loc3_;
            var_5208 = param2;
            var_2535 = getTargetRect(_activeHint.window);
            if(param2 != null)
            {
               animateHint(param2);
            }
            else
            {
               _windowManager.registerUpdateReceiver(this,10);
               update(0);
            }
         }
      }
      
      protected function animateHint(param1:Rectangle) : void
      {
         _hint.x = param1.x;
         _hint.y = param1.y;
         _hint.visible = true;
         var _loc3_:int = param1.x - var_2535.x;
         var _loc6_:int = param1.y - var_2535.y;
         var _loc4_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc6_ * _loc6_);
         var _loc2_:int = 500 - Math.abs(1 / _loc4_ * 100 * 500 * 0.5);
         var _loc8_:int = int(_hint.width);
         var _loc7_:int = int(_hint.height);
         _hint.width *= 0.4;
         _hint.height *= 0.4;
         var _loc5_:Motion = new Queue(new Combo(new EaseOut(new MoveTo(_hint,_loc2_,var_2535.x,var_2535.y),1),new ResizeTo(_hint,_loc2_,_loc8_,_loc7_)),new Callback(motionComplete));
         class_2939.runMotion(_loc5_);
      }
      
      protected function motionComplete(param1:Motion) : void
      {
         _windowManager.registerUpdateReceiver(this,10);
         update(0);
      }
      
      public function hideHint() : void
      {
         _windowManager.removeUpdateReceiver(this);
         _activeHint = null;
         if(!_hint)
         {
            return;
         }
         _hint.dispose();
         _hint = null;
      }
      
      public function hideMatchingHint(param1:String) : void
      {
         if(param1 == activeKey)
         {
            hideHint();
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_activeHint != null && _hint != null && _activeHint.window != null)
         {
            _loc4_ = new Point();
            _activeHint.window.getGlobalPosition(_loc4_);
            if(_loc4_.x == 0 && _loc4_.y == 0)
            {
               return;
            }
            _loc5_ = int(_hint.zoomX);
            _loc6_ = int(_hint.zoomY);
            switch(_activeHint.style - 1)
            {
               case 0:
                  if(_loc4_.y - _hint.height - 10 > 0)
                  {
                     _loc2_ = _loc4_.y - _hint.height;
                     if(_hint.y == 0)
                     {
                        _hint.y = Math.max(_loc2_ - 400,15);
                     }
                     if(_loc2_ - _hint.y > 15 + 10)
                     {
                        _hint.y += 15;
                     }
                     else
                     {
                        _hint.y = _loc2_ - 10 - 5 * Math.abs(Math.sin(getTimer() * 0.003));
                     }
                     _hint.zoomY = 1;
                  }
                  else
                  {
                     _loc3_ = _loc4_.y + _activeHint.window.height;
                     if(_hint.y == 0)
                     {
                        _hint.y = Math.min(_windowManager.context.displayObjectContainer.stage.stageHeight - _hint.height,_hint.y + 400);
                     }
                     if(_loc3_ - _hint.y > 15 + 10)
                     {
                        _hint.y -= 15;
                     }
                     else
                     {
                        _hint.y = _loc3_ + 10 + 5 * Math.abs(Math.sin(getTimer() * 0.003));
                     }
                     _hint.zoomY = -1;
                  }
                  _hint.x = _loc4_.x + (_activeHint.window.width - _hint.width) / 2;
                  break;
               default:
                  if(_loc4_.x + _activeHint.window.width / 2 > _activeHint.window.desktop.width / 2)
                  {
                     _hint.x = _loc4_.x - _hint.width - 10 - 5 * Math.abs(Math.sin(getTimer() * 0.003));
                     _hint.zoomX = 1;
                  }
                  else
                  {
                     _hint.x = _loc4_.x + _activeHint.window.width + 10 + 5 * Math.abs(Math.sin(getTimer() * 0.003));
                     _hint.zoomX = -1;
                  }
                  _hint.y = _loc4_.y + (_activeHint.window.height - _hint.height) / 2;
            }
            if(_hint.zoomX != _loc5_ || _hint.zoomY != _loc6_)
            {
               _hint.invalidate();
            }
            _hint.visible = _activeHint.window.visible;
         }
      }
      
      private function getTargetRect(param1:class_1741) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle();
         var _loc3_:Point = new Point();
         param1.getGlobalPosition(_loc3_);
         switch(_activeHint.style - 1)
         {
            case 0:
               if(_loc3_.y - _hint.height - 10 > 0)
               {
                  _loc2_.y = _loc3_.y - _hint.height - 10;
               }
               else
               {
                  _loc2_.y = _loc3_.y + param1.height + 10;
               }
               _loc2_.x = _loc3_.x + (param1.width - _hint.width) / 2;
               break;
            default:
               if(_loc3_.x + param1.width / 2 > param1.desktop.width / 2)
               {
                  _loc2_.x = _loc3_.x - _hint.width - 10;
               }
               else
               {
                  _loc2_.x = _loc3_.x + param1.width + 10;
               }
               _loc2_.y = _loc3_.y + (param1.height - _hint.height) / 2;
         }
         return _loc2_;
      }
      
      private function get activeKey() : String
      {
         return _activeHint ? _activeHint.key : null;
      }
   }
}

