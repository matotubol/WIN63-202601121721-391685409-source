package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.avatar.animation.class_1815;
   import com.sulake.habbo.avatar.structure.class_1780;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public interface class_48 extends IUnknown
   {
      
      function createAvatarImage(param1:String, param2:String, param3:String = null, param4:class_259 = null, param5:class_1828 = null) : class_1827;
      
      function createBlockedAvatarImage(param1:String, param2:String) : class_1827;
      
      function get assets() : class_40;
      
      function getFigureData() : class_1780;
      
      function getFigureStringWithFigureIds(param1:String, param2:String, param3:Vector.<int>) : String;
      
      function isValidFigureSetForGender(param1:int, param2:String) : Boolean;
      
      function getMandatoryAvatarPartSetIds(param1:String, param2:int) : Array;
      
      function getAssetByName(param1:String) : IAsset;
      
      function get mode() : String;
      
      function set mode(param1:String) : void;
      
      function injectFigureData(param1:XML) : void;
      
      function createFigureContainer(param1:String) : class_1900;
      
      function isFigureReady(param1:class_1900) : Boolean;
      
      function downloadFigure(param1:class_1900, param2:class_259) : void;
      
      function getAnimationManager() : class_1815;
      
      function get events() : IEventDispatcher;
      
      function resetAssetManager() : void;
      
      function resolveClubLevel(param1:class_1900, param2:String, param3:Array = null) : int;
      
      function getItemIds() : Array;
      
      function get effectMap() : Dictionary;
      
      function purgeAssets() : void;
      
      function get isReady() : Boolean;
      
      function resetAllCaches() : void;
   }
}

