package com.sulake.core.window.utils
{
   import com.sulake.core.utils.class_2468;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1892;
   import com.sulake.core.window.components.class_3532;
   import flash.filters.BitmapFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import flash.utils.*;
   
   public class WindowParser implements class_2782
   {
      
      public static const ELEMENT_TAG_EXCLUDE:String = "_EXCLUDE";
      
      public static const ELEMENT_TAG_INCLUDE:String = "_INCLUDE";
      
      public static const const_816:String = "_TEMP";
      
      private static const LAYOUT:String = "layout";
      
      private static const name_3:String = "window";
      
      private static const VARIABLES:String = "variables";
      
      private static const FILTERS:String = "filters";
      
      private static const NAME:String = "name";
      
      private static const STYLE:String = "style";
      
      private static const const_858:String = "dynamic_style";
      
      private static const PARAMS:String = "params";
      
      private static const TAGS:String = "tags";
      
      private static const X:String = "x";
      
      private static const const_293:String = "y";
      
      private static const WIDTH:String = "width";
      
      private static const HEIGHT:String = "height";
      
      private static const VISIBLE:String = "visible";
      
      private static const CAPTION:String = "caption";
      
      private static const ID:String = "id";
      
      private static const BACKGROUND:String = "background";
      
      private static const BLEND:String = "blend";
      
      private static const CLIPPING:String = "clipping";
      
      private static const COLOR:String = "color";
      
      private static const THRESHOLD:String = "treshold";
      
      private static const CHILDREN:String = "children";
      
      private static const WIDTH_MIN:String = "width_min";
      
      private static const const_1106:String = "width_max";
      
      private static const HEIGHT_MIN:String = "height_min";
      
      private static const const_1114:String = "height_max";
      
      private static const TRUE:String = "true";
      
      private static const ZERO:String = "0";
      
      private static const VAR:String = "$";
      
      private static const COMMA:String = ",";
      
      private static const EMPTY:String = "";
      
      private static const const_36:RegExp = /^(\s|\n|\r|\t|\v)*/m;
      
      private static const const_49:RegExp = /(\s|\n|\r|\t|\v)*$/;
      
      protected var var_2305:Dictionary;
      
      protected var var_2515:Dictionary;
      
      protected var var_1896:Dictionary;
      
      protected var var_3135:Dictionary;
      
      protected var _parsedLayoutCache:class_55;
      
      protected var _context:class_1892;
      
      private var _disposed:Boolean = false;
      
      public function WindowParser(param1:class_1892)
      {
         super();
         _context = param1;
         var_2305 = new Dictionary();
         var_2515 = new Dictionary();
         class_3537.fillTables(var_2305,var_2515);
         var_1896 = new Dictionary();
         var_3135 = new Dictionary();
         class_3794.fillTables(var_1896,var_3135);
         _parsedLayoutCache = new class_55();
      }
      
      private static function trimWhiteSpace(param1:String) : String
      {
         param1 = param1.replace(const_49,"");
         return param1.replace(const_36,"");
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         var _loc1_:Object = null;
         if(!_disposed)
         {
            for(_loc1_ in var_2305)
            {
               delete var_2305[_loc1_];
            }
            for(_loc1_ in var_2515)
            {
               delete var_2515[_loc1_];
            }
            for(_loc1_ in var_1896)
            {
               delete var_1896[_loc1_];
            }
            for(_loc1_ in var_3135)
            {
               delete var_3135[_loc1_];
            }
            _parsedLayoutCache.dispose();
            _parsedLayoutCache = null;
            _context = null;
            _disposed = true;
         }
      }
      
      public function parseAndConstruct(param1:XML, param2:class_1741, param3:class_55) : class_1741
      {
         var _loc6_:* = 0;
         var _loc13_:class_1741 = null;
         var _loc8_:* = 0;
         var _loc12_:XMLList = null;
         var _loc9_:XMLList = null;
         var _loc5_:XML = null;
         var _loc4_:XMLList = null;
         var _loc11_:Array = null;
         var _loc10_:* = 0;
         if(param1.localName() == "layout")
         {
            _loc9_ = param1.child("variables");
            if(_loc9_.length() > 0)
            {
               _loc5_ = _loc9_[0];
               while(true)
               {
                  var _loc7_:XMLList = XML(_loc5_[0]).children();
                  if(_loc7_.length() > 0)
                  {
                     if(param3 == null)
                     {
                        param3 = new class_55();
                     }
                     class_2468.parseVariableList(_loc7_,param3);
                  }
               }
               §§goto(addr0148);
            }
            _loc4_ = param1.child("filters").children();
            if(_loc4_.length() > 0)
            {
               _loc11_ = [];
               _loc10_ = 0;
               while(_loc10_ < _loc4_.length())
               {
                  _loc11_.push(buildBitmapFilter(_loc4_[_loc10_]));
                  _loc10_++;
               }
               param2.filters = _loc11_;
            }
            switch(int(_loc6_ = uint((_loc12_ = param1.child("window")).length())))
            {
               case 0:
                  return null;
               case 1:
                  param1 = _loc12_[0];
                  break;
               default:
                  _loc8_ = 0;
                  while(_loc8_ < _loc6_)
                  {
                     _loc13_ = parseSingleWindowEntity(_loc12_[_loc8_],WindowController(param2),param3);
                     _loc8_++;
                  }
                  return _loc13_;
            }
         }
         addr0148:
         if(param1.localName() == "window")
         {
            _loc12_ = param1.children();
            _loc6_ = uint(_loc12_.length());
            if(_loc6_ > 1)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc6_)
               {
                  _loc13_ = parseSingleWindowEntity(_loc12_[_loc8_],WindowController(param2),param3);
                  _loc8_++;
               }
               return _loc13_;
            }
            param1 = param1.children()[0];
         }
         return param1 != null ? parseSingleWindowEntity(param1,WindowController(param2),param3) : null;
      }
      
      private function parseSingleWindowEntity(param1:XML, param2:WindowController, param3:class_55) : class_1741
      {
         var _loc9_:* = 0;
         var _loc27_:String = null;
         var _loc10_:Rectangle = null;
         var _loc24_:XML = null;
         var _loc21_:XMLList = null;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc29_:WindowController = null;
         var _loc12_:String = null;
         var _loc22_:Array = null;
         var _loc19_:Array = null;
         var _loc23_:BitmapFilter = null;
         var _loc11_:IIterator = null;
         var _loc7_:String = "";
         var _loc16_:* = true;
         var _loc4_:* = true;
         var _loc5_:String = "0x00ffffff";
         var _loc6_:Number = 1;
         var _loc26_:* = false;
         var _loc8_:uint = 10;
         var _loc28_:uint = uint(param2 != null ? param2.style : 0);
         var _loc25_:String = "";
         var _loc20_:uint = 0;
         var _loc13_:String = "";
         var _loc14_:int = 0;
         _loc9_ = uint(var_2305[param1.localName()]);
         _loc27_ = unescape(String(parseAttribute(param1,"name",param3,"")));
         _loc28_ = uint(parseAttribute(param1,"style",param3,_loc28_));
         _loc25_ = String(parseAttribute(param1,"dynamic_style",param3,""));
         _loc20_ = uint(parseAttribute(param1,"params",param3,_loc20_));
         _loc13_ = unescape(String(parseAttribute(param1,"tags",param3,_loc13_)));
         _loc10_ = new Rectangle();
         _loc10_.x = Number(parseAttribute(param1,"x",param3,"0"));
         _loc10_.y = Number(parseAttribute(param1,"y",param3,"0"));
         _loc10_.width = Number(parseAttribute(param1,"width",param3,"0"));
         _loc10_.height = Number(parseAttribute(param1,"height",param3,"0"));
         _loc16_ = parseAttribute(param1,"visible",param3,_loc16_.toString()) == "true";
         _loc14_ = int(parseAttribute(param1,"id",param3,_loc14_.toString()));
         if(param1.child("params").length() > 0)
         {
            _loc21_ = param1.child("params").children();
            _loc17_ = uint(_loc21_.length());
            _loc18_ = 0;
            while(_loc18_ < _loc17_)
            {
               _loc24_ = _loc21_[_loc18_];
               _loc12_ = parseAttribute(_loc24_,"name",param3,"") as String;
               if(var_1896[_loc12_] == null)
               {
                  throw new Error("Unknown window parameter \"" + String(_loc24_.attribute("name")) + "\"!");
               }
               _loc20_ |= var_1896[_loc12_];
               _loc18_++;
            }
         }
         _loc7_ = _loc20_ & 0x80000000 ? (param2 ? param2.caption : "") : "";
         _loc7_ = unescape(String(parseAttribute(param1,"caption",param3,_loc7_)));
         if(_loc13_ != "")
         {
            _loc22_ = _loc13_.split(",");
            _loc17_ = _loc22_.length;
            _loc18_ = 0;
            while(_loc18_ < _loc17_)
            {
               _loc22_[_loc18_] = WindowParser.trimWhiteSpace(_loc22_[_loc18_]);
               _loc18_++;
            }
         }
         _loc29_ = _context.create(_loc27_,null,_loc9_,_loc28_,_loc20_,_loc10_,null,param2 is IIterable ? null : param2,_loc14_,parseProperties(param1.child("variables")[0]),_loc25_,_loc22_) as WindowController;
         if(hasAttribute(param1,"width_min"))
         {
            _loc29_.limits.minWidth = int(parseAttribute(param1,"width_min",param3,_loc29_.limits.minWidth));
         }
         if(hasAttribute(param1,"width_max"))
         {
            _loc29_.limits.maxWidth = int(parseAttribute(param1,"width_max",param3,_loc29_.limits.maxWidth));
         }
         if(hasAttribute(param1,"height_min"))
         {
            _loc29_.limits.minHeight = int(parseAttribute(param1,"height_min",param3,_loc29_.limits.minHeight));
         }
         if(hasAttribute(param1,"height_max"))
         {
            _loc29_.limits.maxHeight = int(parseAttribute(param1,"height_max",param3,_loc29_.limits.maxHeight));
         }
         _loc29_.limits.limit();
         _loc26_ = parseAttribute(param1,"background",param3,_loc29_.background.toString()) == "true";
         _loc6_ = Number(parseAttribute(param1,"blend",param3,_loc29_.blend.toString()));
         _loc4_ = parseAttribute(param1,"clipping",param3,_loc29_.clipping.toString()) == "true";
         _loc5_ = String(parseAttribute(param1,"color",param3,_loc29_.color.toString()));
         _loc8_ = uint(parseAttribute(param1,"treshold",param3,_loc29_.mouseThreshold.toString()));
         if(_loc29_.caption != _loc7_)
         {
            _loc29_.caption = _loc7_;
         }
         if(_loc29_.blend != _loc6_)
         {
            _loc29_.blend = _loc6_;
         }
         if(_loc29_.visible != _loc16_)
         {
            _loc29_.visible = _loc16_;
         }
         if(_loc29_.clipping != _loc4_)
         {
            _loc29_.clipping = _loc4_;
         }
         if(_loc29_.background != _loc26_)
         {
            _loc29_.background = _loc26_;
         }
         if(_loc29_.mouseThreshold != _loc8_)
         {
            _loc29_.mouseThreshold = _loc8_;
         }
         var _loc15_:uint = uint(_loc5_.charAt(1) == "x" ? parseInt(_loc5_,16) : uint(_loc5_));
         if(_loc29_.color != _loc15_)
         {
            _loc29_.color = _loc15_;
         }
         _loc21_ = param1.child("filters").children();
         _loc17_ = uint(_loc21_.length());
         if(_loc17_ > 0)
         {
            _loc19_ = [];
            _loc18_ = 0;
            while(_loc18_ < _loc17_)
            {
               _loc23_ = buildBitmapFilter(_loc21_[_loc18_]) as BitmapFilter;
               if(_loc23_ != null)
               {
                  _loc19_.push(_loc23_);
               }
               _loc18_++;
            }
            _loc29_.filters = _loc19_;
         }
         if(_loc29_ != null)
         {
            if(param2 != null)
            {
               if(param2 is IIterable)
               {
                  if(_loc29_.x != _loc10_.x || _loc29_.y != _loc10_.y || _loc29_.width != _loc10_.width || _loc29_.height != _loc10_.height)
                  {
                     if((_loc20_ & 0xC0) == 192)
                     {
                        _loc29_.x = _loc10_.x;
                     }
                     if((_loc20_ & 0x0C00) == 3072)
                     {
                        _loc29_.y = _loc10_.y;
                     }
                  }
                  try
                  {
                     _loc11_ = IIterable(param2).iterator;
                  }
                  catch(e:Error)
                  {
                  }
                  if(_loc11_ != null)
                  {
                     _loc11_[_loc11_.length] = _loc29_;
                  }
                  else
                  {
                     param2.addChild(_loc29_);
                  }
               }
            }
         }
         _loc21_ = param1.child("children");
         if(_loc21_.length() > 0)
         {
            _loc24_ = _loc21_[0];
            _loc21_ = _loc24_.children();
            _loc17_ = uint(_loc21_.length());
            if(_loc29_ is class_3532)
            {
               class_3532(_loc29_).setAutoRearrange(false);
            }
            _loc18_ = 0;
            while(_loc18_ < _loc17_)
            {
               parseAndConstruct(_loc21_[_loc18_],_loc29_,param3);
               _loc18_++;
            }
         }
         if(_loc29_ is class_3532)
         {
            class_3532(_loc29_).setAutoRearrange(true);
         }
         return _loc29_;
      }
      
      private function hasAttribute(param1:XML, param2:String) : Boolean
      {
         return param1.attribute(param2).length() > 0;
      }
      
      private function parseAttribute(param1:XML, param2:String, param3:class_55, param4:Object) : Object
      {
         var _loc5_:XMLList = param1.attribute(param2);
         if(_loc5_.length() == 0)
         {
            return param4;
         }
         var _loc6_:String = String(_loc5_);
         if(param3 != null)
         {
            if(_loc6_.charAt(0) == "$")
            {
               _loc6_ = param3[_loc6_.slice(1,_loc6_.length)];
               if(_loc6_ == null)
               {
                  throw new Error("Shared variable not defined: \"" + param1.attribute(param2) + "\"!");
               }
            }
         }
         return _loc6_;
      }
      
      private function parseProperties(param1:XML) : Array
      {
         return param1 != null ? XMLPropertyArrayParser.parse(param1.children()) : [];
      }
      
      public function windowToXMLString(param1:class_1741) : String
      {
         var _loc17_:class_1741 = null;
         var _loc6_:* = 0;
         var _loc10_:IIterator = null;
         var _loc12_:PropertyStruct = null;
         var _loc4_:String = null;
         if(param1.dynamicStyle.length < 3)
         {
            param1.dynamicStyle = "";
         }
         if(param1.dynamicStyle != "")
         {
            param1.setParamFlag(16,false);
         }
         var _loc11_:String = "";
         var _loc7_:String = var_2515[param1.type];
         var _loc8_:uint = param1.param;
         var _loc13_:uint = param1.style;
         var _loc14_:IRectLimiter = param1.limits;
         var _loc16_:WindowController = param1 as WindowController;
         _loc11_ += "<" + _loc7_ + " x=\"" + param1.x + "\"" + " y=\"" + param1.y + "\"" + " width=\"" + param1.width + "\"" + " height=\"" + param1.height + "\"" + " params=\"" + param1.param + "\"" + " style=\"" + param1.style + "\"" + (param1.dynamicStyle != "" ? " dynamic_style=\"" + param1.dynamicStyle + "\"" : "") + (param1.name != "" ? " name=\"" + escape(param1.name) + "\"" : "") + (param1.caption != "" ? " caption=\"" + escape(param1.caption) + "\"" : "") + (param1.id != 0 ? " id=\"" + param1.id.toString() + "\"" : "") + (param1.color != 16777215 ? " color=\"0x" + param1.alpha.toString(16) + param1.color.toString(16) + "\"" : "") + (param1.blend != 1 ? " blend=\"" + param1.blend.toString() + "\"" : "") + (param1.visible != true ? " visible=\"" + param1.visible.toString() + "\"" : "") + (param1.clipping != true ? " clipping=\"" + param1.clipping.toString() + "\"" : "") + (param1.background != false ? " background=\"" + param1.background.toString() + "\"" : "") + (param1.mouseThreshold != 10 ? " treshold=\"" + param1
         .mouseThreshold.toString() + "\"" : "") + (param1.tags.length > 0 ? " tags=\"" + escape(param1.tags.toString()) + "\"" : "") + (_loc14_.minWidth > -2147483648 ? " width_min=\"" + _loc14_.minWidth + "\"" : "") + (_loc14_.maxWidth < 2147483647 ? " width_max=\"" + _loc14_.maxWidth + "\"" : "") + (_loc14_.minHeight > -2147483648 ? " height_min=\"" + _loc14_.minHeight + "\"" : "") + (_loc14_.maxHeight < 2147483647 ? " height_max=\"" + _loc14_.maxHeight + "\"" : "") + ">\r";
         if(param1.filters && param1.filters.length > 0)
         {
            _loc11_ += "\t<filters>\r";
            for each(var _loc9_ in param1.filters)
            {
               _loc11_ += "\t\t" + filterToXmlString(_loc9_) + "\r";
            }
            _loc11_ += "\t</filters>\r";
         }
         var _loc5_:uint = uint(_loc16_.numChildren);
         var _loc2_:String = "";
         if(_loc16_ is IIterable)
         {
            _loc10_ = IIterable(_loc16_).iterator;
            _loc5_ = _loc10_.length;
            if(_loc5_ > 0)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc17_ = _loc10_[_loc6_] as class_1741;
                  if(_loc17_.tags.indexOf("_EXCLUDE") == -1)
                  {
                     _loc2_ += windowToXMLString(_loc17_);
                  }
                  _loc6_++;
               }
            }
         }
         else
         {
            _loc5_ = uint(_loc16_.numChildren);
            if(_loc5_ > 0)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc17_ = _loc16_.getChildAt(_loc6_);
                  if(_loc17_.tags.indexOf("_EXCLUDE") == -1)
                  {
                     _loc2_ += windowToXMLString(_loc17_);
                  }
                  _loc6_++;
               }
            }
         }
         if(_loc2_.length > 0)
         {
            _loc11_ += "\t<children>\r" + _loc2_ + "\t</children>\r";
         }
         var _loc15_:Array = param1.properties;
         if(_loc15_ != null && _loc15_.length > 0)
         {
            _loc4_ = "\t<variables>\r";
            var _loc3_:Boolean = false;
            _loc6_ = 0;
            while(_loc6_ < _loc15_.length)
            {
               _loc12_ = _loc15_[_loc6_] as PropertyStruct;
               if(_loc12_.valid)
               {
                  _loc4_ += "\t\t" + _loc12_.toXMLString() + "\r";
                  _loc3_ = true;
               }
               _loc6_++;
            }
            _loc4_ += "\t</variables>\r";
            if(_loc3_)
            {
               _loc11_ += _loc4_;
            }
         }
         return _loc11_ + ("</" + _loc7_ + ">\r");
      }
      
      private function buildBitmapFilter(param1:XML) : BitmapFilter
      {
         var _loc2_:BitmapFilter = null;
         var _loc3_:String = param1.localName() as String;
         var _loc4_:String = _loc3_;
         if("DropShadowFilter" === _loc4_)
         {
            _loc2_ = new DropShadowFilter(Number(parseAttribute(param1,"distance",null,"0")),Number(parseAttribute(param1,"angle",null,"45")),uint(parseAttribute(param1,"color",null,"0")),Number(parseAttribute(param1,"alpha",null,"1")),Number(parseAttribute(param1,"blurX",null,"0")),Number(parseAttribute(param1,"blurY",null,"0")),Number(parseAttribute(param1,"strength",null,"1")),int(parseAttribute(param1,"quality",null,"1")),parseAttribute(param1,"inner",null,"false") == "true",parseAttribute(param1,"knockout",null,"false") == "true",parseAttribute(param1,"hideObject",null,"false") == "true");
         }
         return _loc2_;
      }
      
      private function filterToXmlString(param1:BitmapFilter) : String
      {
         var _loc2_:String = null;
         if(param1 is DropShadowFilter)
         {
            _loc2_ = "<DropShadowFilter";
            _loc2_ += DropShadowFilter(param1).distance != 0 ? " distance=\"" + DropShadowFilter(param1).distance + "\"" : "";
            _loc2_ += DropShadowFilter(param1).angle != 45 ? " angle=\"" + DropShadowFilter(param1).angle + "\"" : "";
            _loc2_ += DropShadowFilter(param1).color != 0 ? " color=\"" + DropShadowFilter(param1).color + "\"" : "";
            _loc2_ += DropShadowFilter(param1).alpha != 1 ? " alpha=\"" + DropShadowFilter(param1).alpha + "\"" : "";
            _loc2_ += DropShadowFilter(param1).blurX != 0 ? " blurX=\"" + DropShadowFilter(param1).blurX + "\"" : "";
            _loc2_ += DropShadowFilter(param1).blurY != 0 ? " blurY=\"" + DropShadowFilter(param1).blurY + "\"" : "";
            _loc2_ += DropShadowFilter(param1).strength != 1 ? " strength=\"" + DropShadowFilter(param1).strength + "\"" : "";
            _loc2_ += DropShadowFilter(param1).quality != 1 ? " quality=\"" + DropShadowFilter(param1).quality + "\"" : "";
            _loc2_ += DropShadowFilter(param1).inner != false ? " inner=\"" + DropShadowFilter(param1).inner + "\"" : "";
            _loc2_ += DropShadowFilter(param1).knockout != false ? " knockout=\"" + DropShadowFilter(param1).knockout + "\"" : "";
            _loc2_ += DropShadowFilter(param1).hideObject != false ? " hideObject=\"" + DropShadowFilter(param1).hideObject + "\"" : "";
            _loc2_ += " />";
         }
         return _loc2_;
      }
   }
}

