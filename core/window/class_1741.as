package com.sulake.core.window
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.utils.IRectLimiter;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.display.IBitmapDrawable;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public interface class_1741 extends class_13
   {
      
      function get x() : int;
      
      function get y() : int;
      
      function get id() : int;
      
      function get name() : String;
      
      function get width() : int;
      
      function get height() : int;
      
      function get position() : Point;
      
      function get rectangle() : Rectangle;
      
      function get renderingRectangle() : Rectangle;
      
      function get properties() : Array;
      
      function get procedure() : Function;
      
      function get background() : Boolean;
      
      function get alpha() : uint;
      
      function get color() : uint;
      
      function get blend() : Number;
      
      function get style() : uint;
      
      function get visible() : Boolean;
      
      function get clipping() : Boolean;
      
      function get caption() : String;
      
      function get parent() : class_1741;
      
      function get debug() : Boolean;
      
      function get filters() : Array;
      
      function get mouseThreshold() : uint;
      
      function get ignoreMouseEvents() : Boolean;
      
      function get immediateClickMode() : Boolean;
      
      function get type() : uint;
      
      function get state() : uint;
      
      function get param() : uint;
      
      function get limits() : IRectLimiter;
      
      function get context() : class_1892;
      
      function get desktop() : class_2052;
      
      function get host() : class_1741;
      
      function get tags() : Array;
      
      function get left() : int;
      
      function get top() : int;
      
      function get right() : int;
      
      function get bottom() : int;
      
      function get dynamicStyle() : String;
      
      function get renderingX() : int;
      
      function get renderingY() : int;
      
      function get renderingWidth() : int;
      
      function get renderingHeight() : int;
      
      function get etchingPoint() : Point;
      
      function get dynamicStyleColor() : ColorTransform;
      
      function set dynamicStyleColor(param1:ColorTransform) : void;
      
      function set x(param1:int) : void;
      
      function set y(param1:int) : void;
      
      function set id(param1:int) : void;
      
      function set name(param1:String) : void;
      
      function set width(param1:int) : void;
      
      function set height(param1:int) : void;
      
      function set position(param1:Point) : void;
      
      function set rectangle(param1:Rectangle) : void;
      
      function set properties(param1:Array) : void;
      
      function set procedure(param1:Function) : void;
      
      function set background(param1:Boolean) : void;
      
      function set alpha(param1:uint) : void;
      
      function set color(param1:uint) : void;
      
      function set blend(param1:Number) : void;
      
      function set style(param1:uint) : void;
      
      function set visible(param1:Boolean) : void;
      
      function set clipping(param1:Boolean) : void;
      
      function set caption(param1:String) : void;
      
      function set parent(param1:class_1741) : void;
      
      function set debug(param1:Boolean) : void;
      
      function set filters(param1:Array) : void;
      
      function set mouseThreshold(param1:uint) : void;
      
      function set ignoreMouseEvents(param1:Boolean) : void;
      
      function set immediateClickMode(param1:Boolean) : void;
      
      function set dynamicStyle(param1:String) : void;
      
      function set etching(param1:Array) : void;
      
      function toString() : String;
      
      function clone() : class_1741;
      
      function invalidate(param1:Rectangle = null) : void;
      
      function resolve() : uint;
      
      function buildFromXML(param1:XML, param2:class_55 = null) : Boolean;
      
      function center() : void;
      
      function offset(param1:Number, param2:Number) : void;
      
      function scale(param1:Number, param2:Number) : void;
      
      function fetchDrawBuffer() : IBitmapDrawable;
      
      function getRelativeMousePosition(param1:Point) : void;
      
      function getAbsoluteMousePosition(param1:Point) : void;
      
      function getDrawRegion(param1:Rectangle) : void;
      
      function getMouseRegion(param1:Rectangle) : void;
      
      function getLocalPosition(param1:Point) : void;
      
      function getLocalRectangle(param1:Rectangle) : void;
      
      function hitTestLocalPoint(param1:Point) : Boolean;
      
      function hitTestLocalRectangle(param1:Rectangle) : Boolean;
      
      function getGlobalPosition(param1:Point) : void;
      
      function setGlobalPosition(param1:Point) : void;
      
      function getGlobalRectangle(param1:Rectangle) : void;
      
      function setGlobalRectangle(param1:Rectangle) : void;
      
      function hitTestGlobalPoint(param1:Point) : Boolean;
      
      function hitTestGlobalRectangle(param1:Rectangle) : Boolean;
      
      function resolveVerticalScale() : Number;
      
      function resolveHorizontalScale() : Number;
      
      function convertPointFromLocalToGlobalSpace(param1:Point) : void;
      
      function convertPointFromGlobalToLocalSpace(param1:Point) : void;
      
      function findParentByName(param1:String) : class_1741;
      
      function setStateFlag(param1:uint, param2:Boolean = true) : void;
      
      function getStateFlag(param1:uint) : Boolean;
      
      function testStateFlag(param1:uint, param2:uint = 0) : Boolean;
      
      function setStyleFlag(param1:uint, param2:Boolean = true) : void;
      
      function getStyleFlag(param1:uint) : Boolean;
      
      function testStyleFlag(param1:uint, param2:uint = 0) : Boolean;
      
      function setParamFlag(param1:uint, param2:Boolean = true) : void;
      
      function getParamFlag(param1:uint) : Boolean;
      
      function testParamFlag(param1:uint, param2:uint = 0) : Boolean;
      
      function destroy() : Boolean;
      
      function minimize() : Boolean;
      
      function maximize() : Boolean;
      
      function restore() : Boolean;
      
      function activate() : Boolean;
      
      function deactivate() : Boolean;
      
      function lock() : Boolean;
      
      function unlock() : Boolean;
      
      function enable() : Boolean;
      
      function disable() : Boolean;
      
      function addEventListener(param1:String, param2:Function, param3:int = 0) : void;
      
      function removeEventListener(param1:String, param2:Function) : void;
      
      function hasEventListener(param1:String) : Boolean;
      
      function createProperty(param1:String, param2:Object) : PropertyStruct;
      
      function getDefaultProperty(param1:String) : PropertyStruct;
      
      function enableChildren(param1:Boolean, param2:Array) : void;
      
      function activateChildren(param1:Boolean, param2:Array) : void;
      
      function setVisibleChildren(param1:Boolean, param2:Array) : void;
      
      function isEnabled() : Boolean;
      
      function getChildAt(param1:int) : class_1741;
      
      function getChildByID(param1:int) : class_1741;
      
      function getChildByTag(param1:String) : class_1741;
      
      function getChildByName(param1:String) : class_1741;
      
      function getChildIndex(param1:class_1741) : int;
      
      function enableLookupCache() : void;
      
      function findChildByName(param1:String) : class_1741;
      
      function findChildByTag(param1:String) : class_1741;
      
      function windowIsChild(param1:class_1741) : Boolean;
   }
}

