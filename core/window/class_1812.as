package com.sulake.core.window
{
   import com.sulake.core.window.utils.IIterable;
   import flash.geom.Point;
   
   public interface class_1812 extends class_1741, IIterable
   {
      
      function get numChildren() : int;
      
      function addChild(param1:class_1741) : class_1741;
      
      function addChildAt(param1:class_1741, param2:int) : class_1741;
      
      function removeChild(param1:class_1741) : class_1741;
      
      function removeChildAt(param1:int) : class_1741;
      
      function setChildIndex(param1:class_1741, param2:int) : void;
      
      function swapChildren(param1:class_1741, param2:class_1741) : void;
      
      function swapChildrenAt(param1:int, param2:int) : void;
      
      function groupChildrenWithID(param1:uint, param2:Array, param3:int = 0) : uint;
      
      function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint;
      
      function getChildUnderPoint(param1:Point) : class_1741;
      
      function groupChildrenUnderPoint(param1:Point, param2:Array) : void;
   }
}

