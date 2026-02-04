package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.class_1793;
   import flash.events.Event;
   
   public interface class_2044
   {
      
      function dispose() : void;
      
      function init() : void;
      
      function closed() : void;
      
      function dispatchWidgetEvent(param1:Event) : Boolean;
      
      function get window() : class_1812;
      
      function get viewer() : class_2109;
      
      function get pageId() : int;
      
      function get offers() : Vector.<class_1793>;
      
      function get localization() : class_1998;
      
      function get layoutCode() : String;
      
      function get hasLinks() : Boolean;
      
      function get links() : Array;
      
      function selectOffer(param1:int) : void;
      
      function replaceOffers(param1:Vector.<class_1793>, param2:Boolean = false) : void;
      
      function updateLimitedItemsLeft(param1:int, param2:int) : void;
      
      function get acceptSeasonCurrencyAsCredits() : Boolean;
      
      function get allowDragging() : Boolean;
      
      function set searchPageId(param1:int) : void;
      
      function get mode() : int;
      
      function get isBuilderPage() : Boolean;
   }
}

