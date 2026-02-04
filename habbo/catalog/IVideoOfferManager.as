package com.sulake.habbo.catalog
{
   import com.sulake.habbo.catalog.enum.VideoOfferTypeEnum;
   
   public interface IVideoOfferManager
   {
      
      function get enabled() : Boolean;
      
      function load(param1:IVideoOfferLauncher) : void;
      
      function launch(param1:VideoOfferTypeEnum) : Boolean;
   }
}

