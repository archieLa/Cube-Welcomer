import board
import digitalio
import time

class PresenceSensor:
    def __init__(self):
        self.presenceSignal = digitalio.DigitalInOut(board.D4)
        self.presenceSignal.direction = digitalio.Direction.INPUT
    def checkPresence(self):
        return (not self.presenceSignal.value) #Reverse sensor logic to be more intuitive
                
class SmileySpeakerOutput:
    def __init__(self):
        self.speakerOn = digitalio.DigitalInOut(board.D3)
        self.speakerOn.direction = digitalio.Direction.OUTPUT
        self.smileyOn = digitalio.DigitalInOut(board.D2)
        self.smileyOn.direction = digitalio.Direction.OUTPUT
        self.onDelay = 1
    def outputsOn(self):
        self.speakerOn.value = True
        self.smileyOn.value = True
        self.time.sleep(self.onDelay)
        self.speakerOn.value = False
    def outputsOff(self):
        self.smileyOn.value = False

class CubeWelcomer:
    def __init__(self):
        self.smiley_speaker = SmileySpeakerOutput()
        self.object_in_view = False
    def toGreetOrNotToGreet(self, objectPresent):
        if (self.object_in_view == False and
        objectPresent == True): 
            self.smiley_speaker.outputsOn()
            self.object_in_view = True
        elif (self.object_in_view == True and
        objectPresent == False):
            self.object_in_view = False
            self.smiley_speaker.outputsOff()   
    
cubeWelcomer = CubeWelcomer()
presenceSensor = PresenceSensor()

while True:
    cubeWelcomer.toGreetOrNotToGreet(presenceSensor.checkPresence())   
    time.sleep(0.5)
    