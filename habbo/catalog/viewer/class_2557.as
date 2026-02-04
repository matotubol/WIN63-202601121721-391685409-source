package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   
   public interface class_2557 extends class_13
   {
      
      function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void;
      
      function activate() : void;
      
      function get products() : Vector.<class_1857>;
      
      function get firstProduct() : class_1857;
      
      function set view(param1:class_1812) : void;
      
      function get view() : class_1812;
      
      function set grid(param1:IItemGrid) : void;
      
      function setClubIconLevel(param1:int) : void;
      
      function get offer() : class_1793;
   }
}

