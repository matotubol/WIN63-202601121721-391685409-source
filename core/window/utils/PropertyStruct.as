package com.sulake.core.window.utils
{
   import com.sulake.core.utils.class_55;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class PropertyStruct
   {
      
      public static const const_115:String = "hex";
      
      public static const INT:String = "int";
      
      public static const const_87:String = "uint";
      
      public static const NUMBER:String = "Number";
      
      public static const BOOLEAN:String = "Boolean";
      
      public static const STRING:String = "String";
      
      public static const const_108:String = "Point";
      
      public static const RECTANGLE:String = "Rectangle";
      
      public static const ARRAY:String = "Array";
      
      public static const MAP:String = "Map";
      
      private var _key:String;
      
      private var _value:Object;
      
      private var var_230:String;
      
      private var var_3303:Boolean;
      
      private var var_5286:Boolean;
      
      private var var_2652:Array;
      
      public function PropertyStruct(param1:String, param2:Object, param3:String, param4:Boolean = false, param5:Array = null)
      {
         super();
         _key = param1;
         _value = param2;
         var_230 = param3;
         var_3303 = param4;
         var_5286 = param3 == "Map" || param3 == "Array" || param3 == "Point" || param3 == "Rectangle";
         var_2652 = param5;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get value() : Object
      {
         return _value;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get valid() : Boolean
      {
         return var_3303;
      }
      
      public function get range() : Array
      {
         return var_2652;
      }
      
      public function withNameSpace(param1:String) : PropertyStruct
      {
         return new PropertyStruct(param1 + ":" + _key,_value,var_230,var_3303,var_2652);
      }
      
      public function withoutNameSpace() : PropertyStruct
      {
         return new PropertyStruct(_key.replace(/.*:/,""),_value,var_230,var_3303,var_2652);
      }
      
      public function withValue(param1:Object) : PropertyStruct
      {
         var _loc5_:* = true;
         switch(var_230)
         {
            case "uint":
            case "hex":
               _loc5_ = uint(_value) != uint(param1);
               break;
            case "int":
               _loc5_ = int(_value) != int(param1);
               break;
            case "Number":
               _loc5_ = Number(_value) != Number(param1);
               break;
            case "Boolean":
               _loc5_ = Boolean(_value) != Boolean(param1);
               break;
            case "String":
               _loc5_ = String(_value) != String(param1);
               break;
            case "Array":
               var _loc2_:Array = _value as Array;
               var _loc3_:Array = param1 as Array;
         }
         if(_loc5_)
         {
            return new PropertyStruct(_key,param1,type,true,var_2652);
         }
         return this;
      }
      
      public function toString() : String
      {
         switch(var_230)
         {
            case "hex":
               return "0x" + uint(_value).toString(16);
            case "Boolean":
               return Boolean(_value) == true ? "true" : "false";
            case "Point":
               return "Point(" + Point(_value).x + ", " + Point(_value).y + ")";
            case "Rectangle":
               return "Rectangle(" + Rectangle(_value).x + ", " + Rectangle(_value).y + ", " + Rectangle(_value).width + ", " + Rectangle(_value).height + ")";
            default:
               return String(value);
         }
      }
      
      public function toXMLString() : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc5_:class_55 = null;
         var _loc2_:Array = null;
         switch(var_230)
         {
            case "Map":
               _loc5_ = _value as class_55;
               _loc3_ = "<var key=\"" + _key + "\">\r<value>\r<" + var_230 + ">\r";
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  _loc3_ += "<var key=\"" + _loc5_.getKey(_loc4_) + "\" value=\"" + _loc5_.getWithIndex(_loc4_) + "\" type=\"" + getQualifiedClassName(_loc5_.getWithIndex(_loc4_)) + "\" />\r";
                  _loc4_++;
               }
               _loc3_ += "</" + var_230 + ">\r</value>\r</var>";
               break;
            case "Array":
               _loc2_ = _value as Array;
               _loc3_ = "<var key=\"" + _key + "\">\r<value>\r<" + var_230 + ">\r";
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  _loc3_ += "<var key=\"" + String(_loc4_) + "\" value=\"" + _loc2_[_loc4_] + "\" type=\"" + getQualifiedClassName(_loc2_[_loc4_]) + "\" />\r";
                  _loc4_++;
               }
               _loc3_ += "</" + var_230 + ">\r</value>\r</var>";
               break;
            case "Point":
               var _loc6_:Point = _value as Point;
               _loc3_ = "<var key=\"" + _key + "\">\r<value>\r<" + var_230 + ">\r";
               _loc3_ += "<var key=\"x\" value=\"" + null.x + "\" type=\"" + "int" + "\" />\r";
               _loc3_ += "<var key=\"y\" value=\"" + null.y + "\" type=\"" + "int" + "\" />\r";
               _loc3_ += "</" + var_230 + ">\r</value>\r</var>";
               break;
            case "Rectangle":
               var _loc1_:Rectangle = _value as Rectangle;
               _loc3_ = "<var key=\"" + _key + "\">\r<value>\r<" + var_230 + ">\r";
               _loc3_ += "<var key=\"x\" value=\"" + null.x + "\" type=\"" + "int" + "\" />\r";
               _loc3_ += "<var key=\"y\" value=\"" + null.y + "\" type=\"" + "int" + "\" />\r";
               _loc3_ += "<var key=\"width\" value=\"" + null.width + "\" type=\"" + "int" + "\" />\r";
               _loc3_ += "<var key=\"height\" value=\"" + null.height + "\" type=\"" + "int" + "\" />\r";
               _loc3_ += "</" + var_230 + ">\r</value>\r</var>";
               break;
            case "hex":
               _loc3_ = "<var key=\"" + _key + "\" value=\"" + "0x" + uint(_value).toString(16) + "\" type=\"" + var_230 + "\" />";
               break;
            default:
               _loc3_ = "<var key=\"" + _key + "\" value=\"" + _value + "\" type=\"" + var_230 + "\" />";
         }
         return _loc3_;
      }
   }
}

