package com.sulake.core.utils
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class class_2468
   {
      
      public static const const_115:String = "hex";
      
      public static const INT:String = "int";
      
      public static const const_87:String = "uint";
      
      public static const NUMBER:String = "Number";
      
      public static const FLOAT:String = "float";
      
      public static const BOOLEAN:String = "Boolean";
      
      public static const BOOL:String = "bool";
      
      public static const STRING:String = "String";
      
      public static const const_108:String = "Point";
      
      public static const RECTANGLE:String = "Rectangle";
      
      public static const ARRAY:String = "Array";
      
      public static const MAP:String = "Map";
      
      private static const KEY:String = "key";
      
      private static const TYPE:String = "type";
      
      private static const VALUE:String = "value";
      
      private static const TRUE:String = "true";
      
      private static const const_272:String = "false";
      
      private static const X:String = "x";
      
      private static const const_293:String = "y";
      
      private static const WIDTH:String = "width";
      
      private static const HEIGHT:String = "height";
      
      private static const COMMA:String = ",";
      
      public function class_2468()
      {
         super();
      }
      
      public static function parseVariableList(param1:XMLList, param2:class_55, param3:Array = null) : uint
      {
         var _loc5_:* = 0;
         var _loc4_:uint = uint(param1.length());
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            class_2468.parseVariableToken(param1[_loc5_],param2,param3);
            _loc5_++;
         }
         return _loc4_;
      }
      
      private static function parseVariableToken(param1:XML, param2:class_55, param3:Array = null) : void
      {
         var _loc9_:String = null;
         var _loc7_:String = null;
         var _loc8_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:String = "String";
         _loc8_ = param1.attribute("key");
         if(_loc8_.length() > 0)
         {
            _loc9_ = String(param1.attribute("key"));
         }
         else
         {
            _loc9_ = param1.child("key")[0];
         }
         _loc8_ = param1.attribute("type");
         if(_loc8_.length() > 0)
         {
            _loc6_ = String(param1.attribute("type"));
         }
         _loc8_ = param1.attribute("value");
         if(_loc8_.length() > 0)
         {
            _loc7_ = String(param1.attribute("value"));
         }
         if(_loc7_ != null)
         {
            param2[_loc9_] = class_2468.castStringToType(_loc7_,_loc6_);
         }
         else
         {
            _loc4_ = param1.child("value")[0];
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.child(0)[0];
               _loc7_ = _loc5_.children()[0];
               _loc6_ = _loc5_.localName();
               param2[_loc9_] = class_2468.parseValueType(_loc5_,_loc6_);
            }
            else if(_loc6_ == "Map" || _loc6_ == "Array")
            {
               param2[_loc9_] = class_2468.parseValueType(param1,_loc6_);
            }
         }
         if(param3)
         {
            param3.push(_loc6_);
         }
      }
      
      public static function castStringToType(param1:String, param2:String) : Object
      {
         switch(param2)
         {
            case "uint":
               return uint(param1);
            case "int":
               return int(param1);
            case "Number":
               return Number(param1);
            case "float":
               return Number(param1);
            case "Boolean":
               return param1 == "true" || int(param1) > 0;
            case "bool":
               return param1 == "true" || int(param1) > 0;
            case "hex":
               return uint(param1);
            case "Array":
               return param1.split(",");
            default:
               return param1;
         }
      }
      
      public static function parseValueType(param1:XML, param2:String) : Object
      {
         switch(param2)
         {
            case "String":
               return String(param1);
            case "Point":
               var _loc6_:Point = new Point();
               _loc6_.x = Number(param1.attribute("x"));
               null.y = Number(param1.attribute("y"));
               return null;
            case "Rectangle":
               var _loc3_:Rectangle = new Rectangle();
               null.x = Number(param1.attribute("x"));
               null.y = Number(param1.attribute("y"));
               null.width = Number(param1.attribute("width"));
               null.height = Number(param1.attribute("height"));
               return null;
            case "Array":
               var _loc5_:class_55 = new class_55();
               parseVariableList(param1.children(),null);
               var _loc4_:Array = [];
               for(var _loc7_ in null)
               {
                  null.push(null[null]);
               }
               return null;
            case "Map":
               _loc5_ = new class_55();
               class_2468.parseVariableList(param1.children(),null);
               return null;
            default:
               throw new Error("Unable to parse data type \"" + param2 + "\", unknown type!");
         }
      }
   }
}

