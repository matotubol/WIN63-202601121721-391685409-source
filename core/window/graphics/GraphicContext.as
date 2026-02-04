package com.sulake.core.window.graphics
{
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.IBitmapDrawable;
   import flash.display.MorphShape;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class GraphicContext extends Sprite implements IGraphicContext
   {
      
      public static const const_697:uint = 0;
      
      public static const GC_TYPE_BITMAP:uint = 1;
      
      public static const const_926:uint = 2;
      
      public static const GC_TYPE_CONTAINER:uint = 4;
      
      public static const GC_TYPE_SHAPE:uint = 8;
      
      public static const GC_TYPE_MORPH_SHAPE:uint = 16;
      
      public static const const_495:uint = 64;
      
      public static const const_1169:uint = 128;
      
      public static const const_851:uint = 256;
      
      protected static var var_493:uint = 0;
      
      protected static var var_1150:uint = 0;
      
      protected var var_355:DisplayObjectContainer;
      
      protected var _useAlpha:Boolean;
      
      protected var var_1367:Boolean;
      
      protected var _disposed:Boolean = false;
      
      protected var _rectangle:Rectangle;
      
      protected var var_320:Shape;
      
      public function GraphicContext(param1:String, param2:uint, param3:Rectangle)
      {
         super();
         var_493 = var_493 + 1;
         if(param3 == null)
         {
            param3 = new Rectangle(0,0,0,0);
         }
         this.name = param1;
         this.mouseEnabled = false;
         this.doubleClickEnabled = false;
         this.x = param3.x;
         this.y = param3.y;
         _rectangle = param3;
         _useAlpha = true;
         var_1367 = false;
         switch(param2)
         {
            case 1:
               var_1367 = true;
               setDisplayObject(new Bitmap());
               allocateDrawBuffer(param3.width,param3.height);
               break;
            case 2:
               var _loc4_:TextField = new TextField();
               _loc4_.width = param3.width;
               null.height = param3.height;
               null.type = "input";
               setDisplayObject(null);
               break;
            case 8:
               setDisplayObject(new Shape());
               break;
            case 16:
               setDisplayObject(new MorphShape());
               break;
            case 4:
               setDisplayObject(new Sprite());
               break;
            case 256:
            case 0:
               break;
            default:
               throw new Error("Unsupported graphic context type: " + param2 + "!");
         }
      }
      
      public static function get numGraphicContexts() : uint
      {
         return var_493;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return var_1150;
      }
      
      public function set parent(param1:DisplayObjectContainer) : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         if(param1 != null)
         {
            param1.addChild(this);
         }
      }
      
      public function offSet(param1:Point) : void
      {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      override public function get filters() : Array
      {
         return getDisplayObject().filters;
      }
      
      override public function set filters(param1:Array) : void
      {
         getDisplayObject().filters = param1;
      }
      
      public function get blend() : Number
      {
         return this.alpha;
      }
      
      public function set blend(param1:Number) : void
      {
         this.alpha = param1;
      }
      
      public function get mouse() : Boolean
      {
         return super.mouseEnabled;
      }
      
      public function set mouse(param1:Boolean) : void
      {
         super.mouseEnabled = param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(parent != null)
            {
               parent.removeChild(this);
               parent = null;
            }
            while(numChildContexts > 0)
            {
               removeChildContextAt(0);
            }
            if(var_1367)
            {
               releaseDrawBuffer();
            }
            if(var_355 != null)
            {
               while(var_355.numChildren > 0)
               {
                  var_355.removeChildAt(0);
               }
            }
            var_355 = null;
            while(numChildren > 0)
            {
               removeChildAt(0);
            }
            var_320 = null;
            _disposed = true;
            var_493 = var_493 - 1;
         }
      }
      
      override public function toString() : String
      {
         return "[object GraphicContext name=\"" + name + "\"]";
      }
      
      public function getDrawRegion() : Rectangle
      {
         return _rectangle.clone();
      }
      
      public function setDrawRegion(param1:Rectangle, param2:Boolean, param3:Rectangle) : BitmapData
      {
         var _loc4_:BitmapData = null;
         if(param1.width < 1 || param1.height < 1)
         {
            return null;
         }
         if(var_1367 && param2)
         {
            _loc4_ = allocateDrawBuffer(param1.width,param1.height);
         }
         x = param1.x;
         y = param1.y;
         _rectangle.x = param1.x;
         _rectangle.y = param1.y;
         _rectangle.width = param1.width;
         _rectangle.height = param1.height;
         if(param3)
         {
            if(!var_320)
            {
               var_320 = new Shape();
               var_320.visible = false;
               super.addChild(var_320);
            }
            var_320.graphics.clear();
            var_320.graphics.beginFill(255);
            var_320.graphics.drawRect(param3.x,param3.y,param3.width,param3.height);
            var_320.graphics.endFill();
            getDisplayObject().mask = var_320;
         }
         else if(var_320)
         {
            super.removeChild(var_320);
            var_320.graphics.clear();
            var_320 = null;
            getDisplayObject().mask = null;
         }
         return _loc4_;
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return getChildAt(0);
      }
      
      public function setDisplayObject(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         if(numChildren > 0)
         {
            _loc2_ = removeChildAt(0);
         }
         addChildAt(param1,0);
         param1.mask = var_320;
         return _loc2_;
      }
      
      public function getAbsoluteMousePosition(param1:Point) : void
      {
         param1.x = stage.mouseX;
         param1.y = stage.mouseY;
      }
      
      public function getRelativeMousePosition(param1:Point) : void
      {
         var _loc2_:DisplayObject = getDisplayObject();
         param1.x = _loc2_.mouseX;
         param1.y = _loc2_.mouseY;
      }
      
      public function fetchDrawBuffer() : IBitmapDrawable
      {
         var _loc1_:Bitmap = null;
         if(var_1367)
         {
            _loc1_ = getDisplayObject() as Bitmap;
            if(_loc1_)
            {
               return _loc1_.bitmapData;
            }
         }
         return null;
      }
      
      protected function allocateDrawBuffer(param1:int, param2:int) : BitmapData
      {
         var _loc3_:Bitmap = null;
         var _loc4_:BitmapData = null;
         if(var_1367)
         {
            _loc3_ = getDisplayObject() as Bitmap;
            if(_loc3_)
            {
               _loc4_ = _loc3_.bitmapData;
               if(_loc4_ != null)
               {
                  if(_loc4_.width != param1 || _loc4_.height != param2)
                  {
                     _loc3_.bitmapData = null;
                     var_1150 -= _loc4_.width * _loc4_.height * 4;
                     _loc4_.dispose();
                     _loc4_ = null;
                  }
               }
               if(_loc4_ == null && param1 > 0 && param2 > 0)
               {
                  _loc4_ = new TrackedBitmapData(this,param1,param2,_useAlpha,16777215);
                  var_1150 += _loc4_.width * _loc4_.height * 4;
                  _loc3_.bitmapData = _loc4_;
               }
               return _loc4_;
            }
         }
         return null;
      }
      
      protected function releaseDrawBuffer() : void
      {
         var _loc1_:Bitmap = null;
         var _loc2_:BitmapData = null;
         if(var_1367)
         {
            _loc1_ = getDisplayObject() as Bitmap;
            if(_loc1_)
            {
               _loc2_ = _loc1_.bitmapData;
               if(_loc2_ != null)
               {
                  _loc1_.bitmapData = null;
                  var_1150 -= _loc2_.width * _loc2_.height * 4;
                  _loc2_.dispose();
               }
            }
         }
      }
      
      public function showRedrawRegion(param1:Rectangle) : void
      {
         graphics.clear();
         graphics.lineStyle(1,4278255360);
         graphics.drawRect(0,0,width,height);
         if(param1 != null)
         {
            graphics.lineStyle(1,4278190335);
            graphics.drawRect(param1.x,param1.y,param1.width,param1.height);
         }
      }
      
      protected function setupChildContainer() : DisplayObjectContainer
      {
         if(var_355 == null)
         {
            var_355 = new Sprite();
            var_355.name = this.name + " - Child Container";
            var_355.mouseEnabled = false;
            addChild(var_355);
         }
         return var_355;
      }
      
      protected function removeChildContainer() : void
      {
         if(var_355 != null)
         {
            removeChild(var_355);
            var_355 = null;
         }
      }
      
      public function get numChildContexts() : int
      {
         return var_355 != null ? var_355.numChildren : 0;
      }
      
      public function addChildContext(param1:IGraphicContext) : IGraphicContext
      {
         return setupChildContainer().addChild(param1 as DisplayObject) as IGraphicContext;
      }
      
      public function addChildContextAt(param1:IGraphicContext, param2:int) : IGraphicContext
      {
         return setupChildContainer().addChildAt(param1 as DisplayObject,param2) as IGraphicContext;
      }
      
      public function getChildContextAt(param1:int) : IGraphicContext
      {
         return setupChildContainer().getChildAt(param1) as IGraphicContext;
      }
      
      public function getChildContextByName(param1:String) : IGraphicContext
      {
         return setupChildContainer().getChildByName(param1) as IGraphicContext;
      }
      
      public function getChildContextIndex(param1:IGraphicContext) : int
      {
         return setupChildContainer().getChildIndex(DisplayObject(param1));
      }
      
      public function removeChildContext(param1:IGraphicContext) : IGraphicContext
      {
         return setupChildContainer().removeChild(DisplayObject(param1)) as IGraphicContext;
      }
      
      public function removeChildContextAt(param1:int) : IGraphicContext
      {
         var _loc2_:IGraphicContext = setupChildContainer().getChildAt(param1) as IGraphicContext;
         return _loc2_ == null ? null : removeChildContext(_loc2_);
      }
      
      public function setChildContextIndex(param1:IGraphicContext, param2:int) : void
      {
         var _loc3_:DisplayObject = param1 as DisplayObject;
         if(_loc3_ != null)
         {
            try
            {
               var _loc4_:int = setupChildContainer().getChildIndex(_loc3_);
            }
            catch(error:ArgumentError)
            {
               var _loc5_:Array = [];
               var _loc6_:uint = 0;
               while(0 < numChildContexts)
               {
                  null.push(getChildContextAt(0));
                  _loc6_ = 0 + 1;
               }
               throw new Error("Provided display object is not a child of this!");
            }
            if(param2 != 0)
            {
               setupChildContainer().setChildIndex(_loc3_,param2);
            }
            return;
         }
         throw new Error("Provided child must implement IGraphicContext!");
      }
      
      public function swapChildContexts(param1:IGraphicContext, param2:IGraphicContext) : void
      {
         setupChildContainer().swapChildren(param1 as DisplayObject,param2 as DisplayObject);
      }
      
      public function swapChildContextsAt(param1:int, param2:int) : void
      {
         setupChildContainer().swapChildrenAt(param1,param2);
      }
   }
}

