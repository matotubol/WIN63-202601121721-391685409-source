package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class SkinRenderer implements ISkinRenderer
   {
      
      protected static const ETCHING_POSITION:Dictionary = new Dictionary();
      
      ETCHING_POSITION["top-left"] = {
         "x":-1,
         "y":-1
      };
      ETCHING_POSITION["top"] = {
         "x":0,
         "y":-1
      };
      ETCHING_POSITION["top-right"] = {
         "x":1,
         "y":-1
      };
      ETCHING_POSITION["left"] = {
         "x":-1,
         "y":0
      };
      ETCHING_POSITION["right"] = {
         "x":1,
         "y":0
      };
      ETCHING_POSITION["bottom-left"] = {
         "x":-1,
         "y":1
      };
      ETCHING_POSITION["bottom"] = {
         "x":0,
         "y":1
      };
      ETCHING_POSITION["bottom-right"] = {
         "x":1,
         "y":1
      };
      
      private var _name:String;
      
      private var _disposed:Boolean = false;
      
      protected var _templatesByName:Dictionary;
      
      protected var var_702:Dictionary;
      
      protected var _layoutsByName:Dictionary;
      
      protected var var_824:Dictionary;
      
      public function SkinRenderer(param1:String)
      {
         super();
         _name = param1;
         _templatesByName = new Dictionary();
         var_702 = new Dictionary();
         _layoutsByName = new Dictionary();
         var_824 = new Dictionary();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function parse(param1:IAsset, param2:XMLList, param3:class_40) : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         if(!_disposed)
         {
            for(_loc1_ in _layoutsByName)
            {
               ISkinLayout(_layoutsByName[_loc1_]).dispose();
               delete _layoutsByName[_loc1_];
            }
            _layoutsByName = null;
            var_824 = null;
            for(_loc1_ in _templatesByName)
            {
               ISkinTemplate(_templatesByName[_loc1_]).dispose();
               delete _templatesByName[_loc1_];
            }
            _templatesByName = null;
            var_702 = null;
         }
      }
      
      public function draw(param1:class_1741, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
      }
      
      public function isStateDrawable(param1:uint) : Boolean
      {
         return false;
      }
      
      public function getLayoutByState(param1:uint) : ISkinLayout
      {
         return var_824[param1];
      }
      
      public function registerLayoutForRenderState(param1:uint, param2:String) : void
      {
         var _loc3_:ISkinLayout = _layoutsByName[param2];
         if(_loc3_ == null)
         {
            throw new Error("Layout \"" + param2 + "\" not found in renderer!");
         }
         var_824[param1] = _loc3_;
      }
      
      public function removeLayoutFromRenderState(param1:uint) : void
      {
         delete var_824[param1];
      }
      
      public function hasLayoutForState(param1:uint) : Boolean
      {
         return var_824[param1] != null;
      }
      
      public function getTemplateByState(param1:uint) : ISkinTemplate
      {
         return var_702[param1];
      }
      
      public function registerTemplateForRenderState(param1:uint, param2:String) : void
      {
         var _loc3_:ISkinTemplate = _templatesByName[param2];
         if(_loc3_ == null)
         {
            throw new Error("Template \"" + param2 + "\" not found in renderer!");
         }
         var_702[param1] = _loc3_;
      }
      
      public function removeTemplateFromRenderState(param1:uint) : void
      {
         delete var_702[param1];
      }
      
      public function hasTemplateForState(param1:uint) : Boolean
      {
         return var_702[param1] != null;
      }
      
      public function addLayout(param1:ISkinLayout) : ISkinLayout
      {
         _layoutsByName[param1.name] = param1;
         return param1;
      }
      
      public function getLayoutByName(param1:String) : ISkinLayout
      {
         return _layoutsByName[param1];
      }
      
      public function removeLayout(param1:ISkinLayout) : ISkinLayout
      {
         var _loc2_:* = 0;
         var _loc3_:Object = null;
         param1 = _templatesByName[param1.name];
         if(param1 != null)
         {
            for(_loc3_ in var_824)
            {
               _loc2_ = _loc3_ as uint;
               if(var_824[_loc2_] == param1)
               {
                  removeLayoutFromRenderState(_loc2_);
               }
            }
            delete _layoutsByName[param1.name];
         }
         return param1;
      }
      
      public function addTemplate(param1:ISkinTemplate) : ISkinTemplate
      {
         _templatesByName[param1.name] = param1;
         return param1;
      }
      
      public function getTemplateByName(param1:String) : ISkinTemplate
      {
         return _templatesByName[param1];
      }
      
      public function removeTemplate(param1:ISkinTemplate) : ISkinTemplate
      {
         var _loc2_:* = 0;
         var _loc3_:Object = null;
         param1 = _templatesByName[param1.name];
         if(param1 != null)
         {
            for(_loc3_ in var_702)
            {
               _loc2_ = _loc3_ as uint;
               if(var_702[_loc2_] == param1)
               {
                  removeTemplateFromRenderState(_loc2_);
               }
            }
            delete _templatesByName[param1.name];
         }
         return param1;
      }
   }
}

