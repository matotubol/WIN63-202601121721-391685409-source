package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetMultiColoursEvent extends Event
   {
      
      private var _colours:Array;
      
      private var _backgroundAssetName:String;
      
      private var _colourAssetName:String;
      
      private var _chosenColourAssetName:String;
      
      public function CatalogWidgetMultiColoursEvent(param1:Array, param2:String, param3:String, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super("MULTI_COLOUR_ARRAY",param5,param6);
         _colours = param1;
         _backgroundAssetName = param2;
         _colourAssetName = param3;
         _chosenColourAssetName = param4;
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
   }
}

