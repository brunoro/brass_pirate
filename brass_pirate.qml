//=============================================================================
//  Brass Fingering Plugin
//
//  Copyright (C) 2016 Alexander Schwedler
//  Copyright (C) 2022 Gustavo Brunoro
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2
//  as published by the Free Software Foundation and appearing in
//  the file LICENCE.GPL
//=============================================================================

import QtQuick 2.0
import MuseScore 3.0

MuseScore {
	version: "1.1"
	description: qsTr("This plugin adds slide positions and valve fingerings over notes for brass instruments.")
	menuPath: qsTr("Plugins.Brass Pirate")

	property variant minOffset: -1.0;
	property variant multiNoteSeparator: "\n";
	property variant multiNoteOffset: -2.3;
	property variant pitchOffsetScale: -5.0;
	property variant verbose: true;
	property variant rewindModeScoreStart: 0;
	property variant rewindModeSelectionStart: 1;
	property variant rewindModeSelectionEnd: 2;

	property variant noteTable: {
		26: {valve: "123"}, // E
		27: {valve: "13"},  // F
		28: {valve: "23"},  // Gb
		29: {valve: "12"},  // G
		30: {valve: "1"},   // Ab
		31: {valve: "2"},   // A
		32: {valve: "0"},   // Bb
		33: {valve: "123"}, // B
		34: {valve: "13"},  // C
		35: {valve: "23"},  // Db
		36: {valve: "12"},  // D
		37: {valve: "1"},   // Eb <-- Eb tuba root
		38: {valve: "2"},   // E
		39: {valve: "0"},   // F
		40: {valve: "23"},  // Gb
		41: {valve: "12"},  // G
		42: {valve: "1", slide: "3"},     // Ab
		43: {valve: "2", slide: "2"},     // A
		44: {valve: "0", slide: "1"},     // Bb
		45: {valve: "12", slide: "2"}, // B
		46: {valve: "1", slide: "1"},  // C
		47: {valve: "2", slide: "5"},     // Db
		48: {valve: "0", slide: "4"},     // D
		49: {valve: "1", slide: "3"},     // Eb
		50: {valve: "2", slide: "2"},     // E
		51: {valve: "0", slide: "1"},     // F
		52: {valve: "23", slide: "5"},    // Gb
		53: {valve: "12", slide: "4"},    // G
		54: {valve: "1", slide: "3"},     // Ab
		55: {valve: "2", slide: "2"},     // A
		56: {valve: "0", slide: "1"},     // Bb <-- Bb trumpet root
		57: {valve: "123", slide: "4"},   // B
		58: {valve: "13", slide: "3"},    // C
		59: {valve: "2", slide: "2"},     // Db
		60: {valve: "12", slide: "1"}, // D
		61: {valve: "1", slide: "3"},     // Eb
		62: {valve: "2", slide: "2"},     // E
		63: {valve: "0", slide: "1"},     // F
		64: {valve: "23", slide: "3"},    // Gb
		65: {valve: "12", slide: "2"}, // G
		66: {valve: "1", slide: "1"},  // Ab
		67: {valve: "2", slide: "2"},     // A
		68: {valve: "0", slide: "1"},     // Bb
		69: {valve: "12"}, // B
		70: {valve: "1"},  // C
		71: {valve: "2"},  // Db
		72: {valve: "0"},  // D
		73: {valve: "1"},  // Eb
		74: {valve: "2"},  // E
		75: {valve: "0"},  // F
		76: {valve: "23"}, // Gb
		77: {valve: "12"}, // G
		78: {valve: "1"},  // Ab
		79: {valve: "2"},  // A
		80: {valve: "0"},  // Bb
		81: {valve: "12"}, // B
		82: {valve: "1"},  // C
		83: {valve: "2"},  // Db
		84: {valve: "0"},  // D
	}
	
	function getNoteName (tpc) {
		var noteName = "";
		switch (tpc) {
		case -1: noteName = qsTranslate("InspectorAmbitus", "Fbb") + noteName; break;
		case  0: noteName = qsTranslate("InspectorAmbitus", "Cbb") + noteName; break;
		case  1: noteName = qsTranslate("InspectorAmbitus", "Gbb") + noteName; break;
		case  2: noteName = qsTranslate("InspectorAmbitus", "Dbb") + noteName; break;
		case  3: noteName = qsTranslate("InspectorAmbitus", "Abb") + noteName; break;
		case  4: noteName = qsTranslate("InspectorAmbitus", "Ebb") + noteName; break;
		case  5: noteName = qsTranslate("InspectorAmbitus", "Bbb") + noteName; break;
		case  6: noteName = qsTranslate("InspectorAmbitus", "Fb")  + noteName; break;
		case  7: noteName = qsTranslate("InspectorAmbitus", "Cb")  + noteName; break;

		case  8: noteName = qsTranslate("InspectorAmbitus", "Gb")  + noteName; break;
		case  9: noteName = qsTranslate("InspectorAmbitus", "Db")  + noteName; break;
		case 10: noteName = qsTranslate("InspectorAmbitus", "Ab")  + noteName; break;
		case 11: noteName = qsTranslate("InspectorAmbitus", "Eb")  + noteName; break;
		case 12: noteName = qsTranslate("InspectorAmbitus", "Bb")  + noteName; break;
		case 13: noteName = qsTranslate("InspectorAmbitus", "F")   + noteName; break;
		case 14: noteName = qsTranslate("InspectorAmbitus", "C")   + noteName; break;
		case 15: noteName = qsTranslate("InspectorAmbitus", "G")   + noteName; break;
		case 16: noteName = qsTranslate("InspectorAmbitus", "D")   + noteName; break;
		case 17: noteName = qsTranslate("InspectorAmbitus", "A")   + noteName; break;
		case 18: noteName = qsTranslate("InspectorAmbitus", "E")   + noteName; break;
		case 19: noteName = qsTranslate("InspectorAmbitus", "B")   + noteName; break;

		case 20: noteName = qsTranslate("InspectorAmbitus", "F♯")  + noteName; break;
		case 21: noteName = qsTranslate("InspectorAmbitus", "C♯")  + noteName; break;
		case 22: noteName = qsTranslate("InspectorAmbitus", "G♯")  + noteName; break;
		case 23: noteName = qsTranslate("InspectorAmbitus", "D♯")  + noteName; break;
		case 24: noteName = qsTranslate("InspectorAmbitus", "A♯")  + noteName; break;
		case 25: noteName = qsTranslate("InspectorAmbitus", "E♯")  + noteName; break;
		case 26: noteName = qsTranslate("InspectorAmbitus", "B♯")  + noteName; break;
		case 27: noteName = qsTranslate("InspectorAmbitus", "F♯♯") + noteName; break;
		case 28: noteName = qsTranslate("InspectorAmbitus", "C♯♯") + noteName; break;
		case 29: noteName = qsTranslate("InspectorAmbitus", "G♯♯") + noteName; break;
		case 30: noteName = qsTranslate("InspectorAmbitus", "D♯♯") + noteName; break;
		case 31: noteName = qsTranslate("InspectorAmbitus", "A♯♯") + noteName; break;
		case 32: noteName = qsTranslate("InspectorAmbitus", "E♯♯") + noteName; break;
		case 33: noteName = qsTranslate("InspectorAmbitus", "B♯♯") + noteName; break;
		default: noteName = qsTr("?")   + noteName; break;
		} 
		return noteName;
	}

	function log(msg) {
		if (verbose) {
			console.log(msg);
		}
	}

	function inspect(obj) {
		log(JSON.stringify(obj, null, 2))
	}

	function getLabel(notes, labelMode, baseKey) {
		var text = "";
		for (var i = 0; i < notes.length; i++) {
			if (text != "")
				text += multiNoteSeparator
			
			var index = notes[i].pitch + baseKey;
			log("Pitch: " + index + " | NoteName: " + getNoteName(notes[i].tpc));
			if (index in noteTable  && notes[i].tieBack == null)
				if (labelMode in noteTable[index])
					text += qsTr(noteTable[index][labelMode]);
		}
		return text;
	}

	function getNotePitchOffset(pitch, minPitch, maxPitch) {
		return (pitch - minPitch) / (maxPitch - minPitch) * pitchOffsetScale;
	}

	onRun: {
		if (typeof curScore === 'undefined') {
			Qt.quit();
		}

		var cursor = curScore.newCursor();
		var startStaff;
		var endStaff;
		var endTick;

		cursor.rewind(rewindModeSelectionStart);

		// find iteration range: [startStaff, endStaff]
		var fullScore = false;
		if (!cursor.segment) {
			fullScore = true;
			startStaff = 0;
			endStaff = curScore.nstaves - 1;
		} else {
			startStaff = cursor.staffIdx;
			cursor.rewind(rewindModeSelectionEnd);
			if (cursor.tick == 0) {
				// this happens when the selection includes
				// the last measure of the score.
				// rewind(2) goes after the last segment and sets tick=0
				endTick = curScore.lastSegment.tick + 1;
			} else {
				endTick = cursor.tick;
			}
			endStaff = cursor.staffIdx;
		}

		for (var staff = startStaff; staff <= endStaff; staff++) {
			cursor.voice = 0;
			cursor.staffIdx = staff;

			if (fullScore) {
				cursor.rewind(rewindModeScoreStart);
			} else {
				cursor.rewind(rewindModeSelectionStart);
			}

			// skip any non-brass instruments
			var part = curScore.parts[staff];
			var instrumentId = part.instrumentId;
			if (instrumentId.substring(0, 6) != "brass.") {
				log("skipped instrument: " + instrumentId);
				continue;
			}

			// choose label mode (valve, valveEb or slide)
			log("found instrument: " + instrumentId);

			var sections = instrumentId.split(".");
			if (sections == "undefined" || sections.length < 1)
				return "";

			var instrumentName = sections[1];

			// pick label mode
			var labelMode;
			switch (instrumentName) {
			case "trumpet":
				labelMode = "valve";
				break;
			case "tuba":
				labelMode = "valve";
				break;
			case "slide":
				labelMode = "slide";
				break;
			default:
				labelMode = "valve";
				log("no fingering chart for instrument, defaulting to `valve`")
			}

			log("label mode: " + labelMode);

			// pick base key
			var partName = part.partName;
			var baseKey = 0;

			if ((instrumentName == "tuba") && (partName.includes("Eb") || partName.includes("E♭"))) {
				log("base key: E♭ tuba (-7)");
				baseKey = -7;
			} else {
				log("base key: B♭ trumpet (-2)");
				baseKey = -2;
			}
			// find note ranges
			var minPitch = 84;
			var maxPitch = 26;
			while (cursor.segment && (fullScore || cursor.tick < endTick)) {
				if (cursor.element.notes && cursor.element.notes.length > 0) {
					var pitch = cursor.element.notes[0].pitch;
					minPitch = pitch < minPitch ? pitch : minPitch;
					maxPitch = pitch > maxPitch ? pitch : maxPitch;
				}
				cursor.next();
			}
			log('minPitch: ' + minPitch);
			log('maxPitch: ' + maxPitch);

			if (fullScore) {
				cursor.rewind(rewindModeScoreStart);
			} else {
				cursor.rewind(rewindModeSelectionStart);
			}

			// insert labels
			while (cursor.segment && (fullScore || cursor.tick < endTick)) {
				if (!cursor.element || cursor.element.type != Element.CHORD) {
					cursor.next();
					continue;
				}
				
				var label = getLabel(cursor.element.notes, labelMode, baseKey);
				if (label) {
					var text = newElement(Element.STAFF_TEXT);
					var pitchOffset = getNotePitchOffset(cursor.element.notes[0].pitch, minPitch, maxPitch);
					log("pitchOffset: " + pitchOffset);
					text.text = label;
					text.offsetY = minOffset + (cursor.element.notes.length - 1) * multiNoteOffset + pitchOffset;
					cursor.add(text);
				}
				
				cursor.next();
			}
		}
		
		Qt.quit();
	}	
}
