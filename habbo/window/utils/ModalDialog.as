package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.class_1892;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ModalDialog implements IModalDialog
   {
      
      private static const MODAL_DIALOG_LAYER:int = 3;
      
      private static var var_360:Stage = null;
      
      private static var _windowManager:HabboWindowManagerComponent;
      
      private static var _container:class_1812;
      
      private static var var_2132:int;
      
      private static const COLOR_TRANSFORM:ColorTransform = new ColorTransform(0.25,0.25,0.25);
      
      private var _disposed:Boolean;
      
      private var var_537:class_1741;
      
      private var _background:class_2251;
      
      public function ModalDialog(param1:HabboWindowManagerComponent, param2:XML)
      {
         super();
         initialiseStaticMembers(param1);
         _background = modalContext.create("","",21,0,1,new Rectangle(0,0,1,1),null,_container,0) as class_2251;
         var_537 = _windowManager.buildFromXML(param2,3);
         _container.addChild(var_537);
         var_537.center();
         _container.visible = true;
         refresh();
      }
      
      private static function initialiseStaticMembers(param1:HabboWindowManagerComponent) : void
      {
         if(var_360 == null)
         {
            _windowManager = param1;
            var_360 = _windowManager.context.displayObjectContainer.stage;
            _container = modalContext.create("","",4,0,0,new Rectangle(0,0,1,1),null,null,0) as class_1812;
            var_360.addEventListener("resize",onResize);
            var_360.addEventListener("enterFrame",onEnterFrame);
         }
      }
      
      private static function get modalContext() : class_1892
      {
         return _windowManager.getWindowContext(3);
      }
      
      private static function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc2_:class_2052 = null;
         var _loc9_:class_1741 = null;
         if(_container == null)
         {
            return;
         }
         var _loc8_:* = _container.numChildren == 0;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = _windowManager.getWindowContext(_loc4_).getDesktopWindow();
            _loc2_.visible = _loc8_;
            if(_loc8_)
            {
               for each(_loc9_ in _loc2_.iterator)
               {
                  _loc9_.invalidate();
               }
            }
            _loc4_++;
         }
         if(_loc8_)
         {
            return;
         }
         var _loc5_:Rectangle = new Rectangle(0,0,Math.max(1,var_360.stageWidth),Math.max(1,var_360.stageHeight));
         _container.rectangle = _loc5_;
         _loc4_ = 0;
         while(_loc4_ < _container.numChildren)
         {
            _loc9_ = _container.getChildAt(_loc4_);
            if(_loc4_ % 2 == 0)
            {
               _loc9_.rectangle = _loc5_;
               class_2251(_loc9_).bitmap = null;
            }
            else
            {
               _loc9_.center();
            }
            _loc4_++;
         }
         var _loc1_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,false,0);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            var _loc3_:class_1892 = _windowManager.getWindowContext(_loc4_);
            _loc4_++;
         }
         _loc1_.colorTransform(_loc1_.rect,COLOR_TRANSFORM);
         _loc4_ = 0;
         while(_loc4_ < _container.numChildren)
         {
            _loc9_ = _container.getChildAt(_loc4_);
            if(_loc4_ % 2 == 0)
            {
               var _loc6_:class_2251 = _loc9_ as class_2251;
               if(_loc4_ >= 2)
               {
                  null.bitmap = _loc1_.clone();
                  _loc1_ = null.bitmap;
                  var _loc7_:class_1741 = _container.getChildAt(_loc4_ - 1);
                  _loc1_.draw(WindowController(null).getGraphicContext(true),new Matrix(1,0,0,1,null.x,null.y),COLOR_TRANSFORM);
               }
               else
               {
                  null.bitmap = _loc1_;
               }
            }
            _loc9_.visible = _loc4_ >= _container.numChildren - 2;
            _loc9_.invalidate();
            _loc4_++;
         }
      }
      
      private static function onResize(param1:Event) : void
      {
         if(_container == null || _container.numChildren <= 0)
         {
            return;
         }
         var_2132 = 2;
         _container.getChildAt(_container.numChildren - 1).center();
      }
      
      private static function onEnterFrame(param1:Event) : void
      {
         if(_container == null || _container.numChildren <= 0)
         {
            return;
         }
         if(var_2132 > 0)
         {
            var_2132 = var_2132 - 1;
            if(var_2132 == 0)
            {
               refresh();
            }
         }
      }
      
      public function get rootWindow() : class_1741
      {
         return var_537;
      }
      
      public function get background() : class_2251
      {
         return _background;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_background != null)
            {
               _background.dispose();
               _background = null;
            }
            if(var_537 != null)
            {
               var_537.dispose();
               var_537 = null;
            }
            refresh();
            if(_container != null && _container.numChildren == 0)
            {
               _container.visible = false;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

