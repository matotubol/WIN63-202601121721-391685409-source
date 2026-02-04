package com.sulake.habbo.game.snowwar
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   
   public class KeyboardControl implements class_13
   {
      
      private static const NUMBER_0:uint = 48;
      
      private static const NUMBER_1:uint = 49;
      
      private static const NUMBER_2:uint = 50;
      
      private static const NUMBER_3:uint = 51;
      
      private static const NUMBER_4:uint = 52;
      
      private static const NUMBER_5:uint = 53;
      
      private static const NUMBER_6:uint = 54;
      
      private static const NUMBER_7:uint = 55;
      
      private static const NUMBER_8:uint = 56;
      
      private static const NUMBER_9:uint = 57;
      
      private static const A:uint = 65;
      
      private static const B:uint = 66;
      
      private static const const_1171:uint = 67;
      
      private static const D:uint = 68;
      
      private static const E:uint = 69;
      
      private static const F:uint = 70;
      
      private static const const_226:uint = 71;
      
      private static const const_919:uint = 72;
      
      private static const I:uint = 73;
      
      private static const const_325:uint = 74;
      
      private static const const_948:uint = 75;
      
      private static const const_172:uint = 76;
      
      private static const M:uint = 77;
      
      private static const N:uint = 78;
      
      private static const const_183:uint = 79;
      
      private static const const_1068:uint = 80;
      
      private static const const_1257:uint = 81;
      
      private static const const_433:uint = 82;
      
      private static const S:uint = 83;
      
      private static const const_800:uint = 84;
      
      private static const U:uint = 85;
      
      private static const V:uint = 86;
      
      private static const W:uint = 87;
      
      private static const X:uint = 88;
      
      private static const const_293:uint = 89;
      
      private static const const_453:uint = 90;
      
      private static const const_1260:uint = 186;
      
      private static const EQUAL:uint = 187;
      
      private static const COMMA:uint = 188;
      
      private static const MINUS:uint = 189;
      
      private static const PERIOD:uint = 190;
      
      private static const SLASH:uint = 191;
      
      private static const BACKQUOTE:uint = 192;
      
      private static const LEFTBRACKET:uint = 219;
      
      private static const BACKSLASH:uint = 220;
      
      private static const RIGHTBRACKET:uint = 221;
      
      private static const const_217:uint = 222;
      
      private static const ALTERNATE:uint = 18;
      
      private static const BACKSPACE:uint = 8;
      
      private static const CAPS_LOCK:uint = 20;
      
      private static const COMMAND:uint = 15;
      
      private static const CONTROL:uint = 17;
      
      private static const DELETE:uint = 46;
      
      private static const DOWN:uint = 40;
      
      private static const const_126:uint = 35;
      
      private static const ENTER:uint = 13;
      
      private static const ESCAPE:uint = 27;
      
      private static const F1:uint = 112;
      
      private static const F2:uint = 113;
      
      private static const F3:uint = 114;
      
      private static const F4:uint = 115;
      
      private static const F5:uint = 116;
      
      private static const F6:uint = 117;
      
      private static const F7:uint = 118;
      
      private static const F8:uint = 119;
      
      private static const F9:uint = 120;
      
      private static const F10:uint = 121;
      
      private static const F11:uint = 122;
      
      private static const F12:uint = 123;
      
      private static const F13:uint = 124;
      
      private static const F14:uint = 125;
      
      private static const F15:uint = 126;
      
      private static const HOME:uint = 36;
      
      private static const INSERT:uint = 45;
      
      private static const const_47:uint = 37;
      
      private static const NUMPAD:uint = 21;
      
      private static const NUMPAD_0:uint = 96;
      
      private static const NUMPAD_1:uint = 97;
      
      private static const NUMPAD_2:uint = 98;
      
      private static const NUMPAD_3:uint = 99;
      
      private static const NUMPAD_4:uint = 100;
      
      private static const NUMPAD_5:uint = 101;
      
      private static const NUMPAD_6:uint = 102;
      
      private static const NUMPAD_7:uint = 103;
      
      private static const NUMPAD_8:uint = 104;
      
      private static const NUMPAD_9:uint = 105;
      
      private static const NUMPAD_ADD:uint = 107;
      
      private static const NUMPAD_DECIMAL:uint = 110;
      
      private static const NUMPAD_DIVIDE:uint = 111;
      
      private static const NUMPAD_ENTER:uint = 108;
      
      private static const NUMPAD_MULTIPLY:uint = 106;
      
      private static const NUMPAD_SUBTRACT:uint = 109;
      
      private static const PAGE_DOWN:uint = 34;
      
      private static const PAGE_UP:uint = 33;
      
      private static const RIGHT:uint = 39;
      
      private static const SHIFT:uint = 16;
      
      private static const const_627:uint = 32;
      
      private static const TAB:uint = 9;
      
      private static const const_55:uint = 38;
      
      private var var_360:Stage;
      
      private var var_1068:Array = [];
      
      private var var_81:Direction8;
      
      public function KeyboardControl(param1:Stage)
      {
         super();
         var_360 = param1;
         param1.addEventListener("keyDown",keyboardEventHandler);
         param1.addEventListener("keyUp",keyboardEventHandler);
      }
      
      public function dispose() : void
      {
         var_360.removeEventListener("keyDown",keyboardEventHandler);
         var_360.removeEventListener("keyUp",keyboardEventHandler);
         var_360 = null;
         var_81 = null;
         var_1068 = [];
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      private function keyboardEventHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = int(var_1068.indexOf(param1.keyCode));
         switch(param1.type)
         {
            case "keyDown":
               if(_loc2_ == -1)
               {
                  var_1068.push(param1.keyCode);
               }
               break;
            case "keyUp":
               if(_loc2_ > -1)
               {
                  var_1068.splice(_loc2_,1);
               }
         }
         var_81 = null;
         if(var_1068.length == 0)
         {
            return;
         }
         if(var_1068.length >= 2)
         {
            if(isDown(38) && isDown(37))
            {
               var_81 = Direction8.W;
            }
            else if(isDown(38) && isDown(39))
            {
               var_81 = Direction8.N;
            }
            else if(isDown(40) && isDown(37))
            {
               var_81 = Direction8.S;
            }
            else if(isDown(40) && isDown(39))
            {
               var_81 = Direction8.E;
            }
         }
         else if(isDown(38))
         {
            var_81 = Direction8.NW;
         }
         else if(isDown(40))
         {
            var_81 = Direction8.SE;
         }
         else if(isDown(37))
         {
            var_81 = Direction8.SW;
         }
         else if(isDown(39))
         {
            var_81 = Direction8.NE;
         }
         else if(isDown(81))
         {
            var_81 = Direction8.W;
         }
         else if(isDown(87))
         {
            var_81 = Direction8.NW;
         }
         else if(isDown(69))
         {
            var_81 = Direction8.N;
         }
         else if(isDown(65))
         {
            var_81 = Direction8.SW;
         }
         else if(isDown(68))
         {
            var_81 = Direction8.NE;
         }
         else if(isDown(90))
         {
            var_81 = Direction8.S;
         }
         else if(isDown(88))
         {
            var_81 = Direction8.SE;
         }
         else if(isDown(67))
         {
            var_81 = Direction8.E;
         }
      }
      
      private function isDown(param1:int) : Boolean
      {
         return var_1068.indexOf(param1) > -1;
      }
      
      public function get direction() : Direction8
      {
         return var_81;
      }
   }
}

