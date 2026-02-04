package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetColoursEvent extends Event
   {
      
      private var _colours:Array;
      
      private var _backgroundAssetName:String;
      
      private var _colourAssetName:String;
      
      private var _chosenColourAssetName:String;
      
      private var _index:int;
      
      public function CatalogWidgetColoursEvent(param1:Array, param2:String, param3:String, param4:String, param5:int = 0, param6:Boolean = false, param7:Boolean = false)
      {
         super("COLOUR_ARRAY",param6,param7);
         _colours = param1;
         _backgroundAssetName = param2;
         _colourAssetName = param3;
         _chosenColourAssetName = param4;
         _index = param5;
      }
      
      public function get colours() : Array
      {
         return _colours;
      }
      
      public function get backgroundAssetName() : String
      {
         return _backgroundAssetName;
      }
      
      public function get colourAssetName() : String
      {
         return _colourAssetName;
      }
      
      public function get chosenColourAssetName() : String
      {
         return _chosenColourAssetName;
      }
      
      public function get index() : int
      {
         return _index;
      }
   }
}

