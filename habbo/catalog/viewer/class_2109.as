package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.room.IRoomEngine;
   import flash.events.Event;
   
   public interface class_2109
   {
      
      function showCatalogPage(param1:int, param2:String, param3:class_1998, param4:Vector.<class_1793>, param5:int, param6:Boolean) : void;
      
      function dispatchWidgetEvent(param1:Event) : Boolean;
      
      function get catalog() : IHabboCatalog;
      
      function get roomEngine() : IRoomEngine;
      
      function dispose() : void;
      
      function getCurrentLayoutCode() : String;
      
      function get viewerTags() : Array;
   }
}

