package com.sulake.habbo.window.utils
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.graphics.SkinContainer;
   import com.sulake.core.window.graphics.renderer.BitmapDataRenderer;
   import com.sulake.core.window.graphics.renderer.BitmapSkinRenderer;
   import com.sulake.core.window.graphics.renderer.FillSkinRenderer;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import com.sulake.core.window.graphics.renderer.LabelRenderer;
   import com.sulake.core.window.graphics.renderer.NullSkinRenderer;
   import com.sulake.core.window.graphics.renderer.ShapeSkinRenderer;
   import com.sulake.core.window.graphics.renderer.SkinRenderer;
   import com.sulake.core.window.graphics.renderer.TextSkinRenderer;
   import com.sulake.core.window.utils.DefaultAttStruct;
   import com.sulake.core.window.utils.class_2784;
   import com.sulake.core.window.utils.class_3537;
   import flash.utils.Dictionary;
   
   public class class_2213
   {
      
      private static const RENDERER_TYPE_SKIN:String = "skin";
      
      private static const RENDERER_TYPE_BITMAP:String = "bitmap";
      
      private static const RENDERER_TYPE_FILL:String = "fill";
      
      private static const RENDERER_TYPE_TEXT:String = "text";
      
      private static const RENDERER_TYPE_LABEL:String = "label";
      
      private static const RENDERER_TYPE_SHAPE:String = "shape";
      
      private static const RENDERER_TYPE_UNKNOWN:String = "unknown";
      
      private static const RENDERER_TYPE_NULL:String = "null";
      
      public function class_2213()
      {
         super();
      }
      
      public static function parse(param1:XML, param2:class_40, param3:SkinContainer) : void
      {
         var _loc9_:XML = null;
         var _loc19_:XMLList = null;
         var _loc8_:String = null;
         var _loc15_:String = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc27_:String = null;
         var _loc10_:String = null;
         var _loc28_:IAsset = null;
         var _loc4_:ISkinRenderer = null;
         var _loc14_:String = null;
         var _loc16_:Class = null;
         var _loc26_:DefaultAttStruct = null;
         var _loc30_:XMLList = null;
         var _loc25_:String = null;
         var _loc13_:IAsset = null;
         var _loc23_:XML = null;
         var _loc21_:String = null;
         var _loc24_:* = 0;
         var _loc18_:Dictionary = new Dictionary();
         var _loc20_:Dictionary = new Dictionary();
         class_3537.fillTables(_loc18_,_loc20_);
         var _loc17_:Dictionary = new Dictionary();
         var _loc11_:Dictionary = new Dictionary();
         class_2784.fillTables(_loc17_,_loc11_);
         var _loc12_:Dictionary = new Dictionary();
         _loc12_["skin"] = BitmapSkinRenderer;
         _loc12_["bitmap"] = BitmapDataRenderer;
         _loc12_["fill"] = FillSkinRenderer;
         _loc12_["text"] = TextSkinRenderer;
         _loc12_["label"] = LabelRenderer;
         _loc12_["shape"] = ShapeSkinRenderer;
         _loc12_["unknown"] = SkinRenderer;
         _loc12_["null"] = NullSkinRenderer;
         if(param1 != null)
         {
            _loc30_ = param1.child("window");
            var _loc7_:uint = uint(_loc30_.length());
            var _loc22_:Array = [];
            if(_loc7_ > 0)
            {
               _loc24_ = 0;
               while(_loc24_ < _loc7_)
               {
                  _loc9_ = _loc30_[_loc24_];
                  _loc8_ = _loc9_.attribute("type");
                  _loc21_ = _loc9_.attribute("intent");
                  _loc15_ = _loc9_.attribute("style");
                  _loc5_ = _loc9_.attribute("blend") as uint;
                  _loc6_ = _loc9_.attribute("color") as uint;
                  _loc27_ = _loc9_.attribute("asset");
                  _loc10_ = _loc9_.attribute("layout");
                  _loc25_ = _loc9_.attribute("window_layout");
                  _loc14_ = _loc9_.attribute("renderer");
                  _loc19_ = _loc9_.child("states");
                  _loc16_ = _loc12_[_loc14_];
                  if(_loc16_)
                  {
                     _loc4_ = new _loc16_(_loc10_);
                     if(_loc4_)
                     {
                        _loc28_ = param2.getAssetByName(_loc27_);
                        _loc4_.parse(_loc28_,_loc19_,param2);
                        if(_loc28_ && _loc22_.indexOf(_loc28_) == -1)
                        {
                           _loc22_.push(_loc28_);
                        }
                     }
                  }
                  _loc26_ = new DefaultAttStruct();
                  _loc26_.threshold = _loc9_.@treshold[0] ? uint(_loc9_.@treshold[0]) : 10;
                  _loc26_.background = _loc9_.@background[0] ? _loc9_.@background[0] == "true" : false;
                  _loc26_.blend = _loc9_.@blend[0] ? Number(_loc9_.@blend[0]) : 1;
                  _loc26_.color = _loc9_.@color[0] ? uint(_loc9_.@color[0]) : 16777215;
                  _loc26_.width_min = _loc9_.@width_min[0] ? int(_loc9_.@width_min[0]) : -2147483648;
                  _loc26_.width_max = _loc9_.@width_max[0] ? int(_loc9_.@width_max[0]) : 2147483647;
                  _loc26_.height_min = _loc9_.@height_min[0] ? int(_loc9_.@height_min[0]) : -2147483648;
                  _loc26_.height_max = _loc9_.@height_max[0] ? int(_loc9_.@height_max[0]) : 2147483647;
                  _loc23_ = null;
                  if(_loc25_ != null)
                  {
                     _loc13_ = param2.getAssetByName(_loc25_);
                     if(_loc13_ != null)
                     {
                        _loc23_ = _loc13_.content as XML;
                     }
                  }
                  param3.addSkinRenderer(_loc18_[_loc8_],uint(_loc15_),_loc21_,_loc4_,_loc23_,_loc26_);
                  _loc24_++;
               }
               for each(var _loc29_ in _loc22_)
               {
                  _loc29_.dispose();
               }
            }
         }
      }
   }
}

