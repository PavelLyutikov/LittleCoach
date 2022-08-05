//
//  QuestionModelES.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 22.05.2022.
//

import GameKit

struct QuestionModelES {
    
    var dictionaryName = UserDefaults.standard.string(forKey: "dictionaryName")
    
//MARK: - Basic
    let iYou = [
        Question(interrogative: "I", transcriotion: "[aɪ]", answers: ["Yo", "Ellos", "Usted", "Ella"], correctAnswerIndex: 0, sound: "i"),
        Question(interrogative: "You", transcriotion: "[juː]", answers: ["Tú", "Ello", "Él", "Nosotros"], correctAnswerIndex: 0, sound: "you"),
        Question(interrogative: "You", transcriotion: "[juː]", answers: ["Ella", "Yo", "Usted", "Ellos"], correctAnswerIndex: 2, sound: "you"),
        Question(interrogative: "He", transcriotion: "[hiː]", answers: ["Nosotros", "Tú", "Ello", "Él"], correctAnswerIndex: 3, sound: "he"),
        Question(interrogative: "She", transcriotion: "[ʃiː]", answers: ["Ellos", "Ella", "Usted", "Yo"], correctAnswerIndex: 1, sound: "she"),
        Question(interrogative: "It", transcriotion: "[ɪt]", answers: ["Nosotros", "Él", "Ello", "Tú"], correctAnswerIndex: 2, sound: "it"),
        Question(interrogative: "They", transcriotion: "[ðeɪ]", answers: ["Yo", "Ellos", "Ella", "Usted"], correctAnswerIndex: 1, sound: "they"),
        Question(interrogative: "We", transcriotion: "[wiː]", answers: ["Ello", "Tú", "Él", "Nosotros"], correctAnswerIndex: 3, sound: "we")
    ]
    let iYouComplex = [
        Question(interrogative: "My", transcriotion: "[maɪ]", answers: ["Tu", "Mi", "Nuestro", "Su"], correctAnswerIndex: 1, sound: "my"),
        Question(interrogative: "Me", transcriotion: "[miː]", answers: ["Nosotros", "Ellos", "Te", "Me"], correctAnswerIndex: 3, sound: "me"),
        Question(interrogative: "Your", transcriotion: "[jɔː]", answers: ["Mi", "Nuestro", "Tu", "Me"], correctAnswerIndex: 2, sound: "your"),
        Question(interrogative: "You", transcriotion: "[juː]", answers: ["Te", "Su", "Ellos", "Nosotros"], correctAnswerIndex: 0, sound: "you"),
        Question(interrogative: "Our", transcriotion: "[ˈaʊə]", answers: ["Me", "Mi", "Tu", "Nuestro"], correctAnswerIndex: 3, sound: "our"),
        Question(interrogative: "Us", transcriotion: "[us]", answers: ["Te", "Me", "Nosotros", "Ellos"], correctAnswerIndex: 2, sound: "us"),
        Question(interrogative: "Their", transcriotion: "[ðeə]", answers: ["Su", "Tu", "Nuestro", "Mi"], correctAnswerIndex: 0, sound: "their"),
        Question(interrogative: "Them", transcriotion: "[ðeɪ]", answers: ["Te", "Ellos", "Nosotros", "Me"], correctAnswerIndex: 1, sound: "them"),
        Question(interrogative: "His", transcriotion: "[hɪz]", answers: ["Su", "Tu", "Nuestro", "Mi"], correctAnswerIndex: 0, sound: "his"),
        Question(interrogative: "Her", transcriotion: "[hɜː]", answers: ["Nosotros", "Ellos", "Su", "Te"], correctAnswerIndex: 2, sound: "her")
    ]
    let hello = [
        Question(interrogative: "Hello", transcriotion: "[həˈləʊ]", answers: ["Adiós", "Hola", "Por favor", "Siento"], correctAnswerIndex: 1, sound: "hello"),
        Question(interrogative: "Hi", transcriotion: "[haɪ]", answers: ["Hola", "Buenas tardes", "Perdóneme", "Siento"], correctAnswerIndex: 0, sound: "hi"),
        Question(interrogative: "Bye", transcriotion: "[baɪ]", answers: ["Perdóneme", "Siento", "Por favor", "Adiós"], correctAnswerIndex: 3, sound: "bye"),
        Question(interrogative: "Good Morning", transcriotion: "[ɡʊd ˈmɔːnɪŋ]", answers: ["Buenas noches", "Hola", "Buenos días", "Buenas tardes"], correctAnswerIndex: 2, sound: "goodMorning"),
        Question(interrogative: "Good Afternoon", transcriotion: "[gʊd ɑːftəˈnuːn]", answers: ["Buenas tardes", "Adiós", "Buenos días", "Buenas noches"], correctAnswerIndex: 0, sound: "goodAfternoon"),
        Question(interrogative: "Good Evening", transcriotion: "[gʊd ˈiːvnɪŋ]", answers: ["Hola", "Buenas noches", "Buenos días", "Buenas tardes"], correctAnswerIndex: 1, sound: "goodEvening"),
        Question(interrogative: "Good Night", transcriotion: "[gʊd naɪt]", answers: ["Buenas tardes", "Adiós", "Buenas noches", "Buenos días"], correctAnswerIndex: 2, sound: "goodNight"),
        Question(interrogative: "Goodbye", transcriotion: " [gʊdˈbaɪ]", answers: ["Hola", "Por favor", "Perdóneme", "Adiós"], correctAnswerIndex: 3, sound: "goodbye"),
        Question(interrogative: "Sorry", transcriotion: "[ˈsɒrɪ]", answers: ["Buenas tardes", "Buenas noches", "Siento", "Por favor"], correctAnswerIndex: 2, sound: "sorry"),
        Question(interrogative: "Excuse me", transcriotion: "[ɪksˈkjuːs miː]", answers: ["Perdóneme", "Hola", "Buenos días", "Por favor"], correctAnswerIndex: 0, sound: "excuseMe"),
        Question(interrogative: "Thank You", transcriotion: "[θæŋk juː]", answers: ["Siento", "Adiós", "Perdóneme", "Gracias"], correctAnswerIndex: 3, sound: "thankYou"),
        Question(interrogative: "Please", transcriotion: "[pliːz]", answers: ["Hola", "Por favor", "Siento", "Perdóneme"], correctAnswerIndex: 1, sound: "please")
    ]
     
    let question = [
        Question(interrogative: "Who?", transcriotion: "[huː]", answers: ["¿Dónde?", "¿Quién?", "¿Por qué?", "¿Cuánto?"], correctAnswerIndex: 1, sound: "who"),
        Question(interrogative: "What?", transcriotion: "[wɒt]", answers: ["¿Cuyo?", "¿Cómo?", "¿Qué?", "¿Con quién?"], correctAnswerIndex: 2, sound: "what"),
        Question(interrogative: "When?", transcriotion: "[wen]", answers: ["¿Con quién?", "¿Cuál?", "¿Cuánto tiempo?", "¿Cuándo?"], correctAnswerIndex: 3, sound: "when"),
        Question(interrogative: "Where?", transcriotion: "[weə]", answers: ["¿Dónde?", "¿Quién?", "¿Cuánto?", "¿Por qué?"], correctAnswerIndex: 0, sound: "where"),
        Question(interrogative: "How?", transcriotion: "[haʊ]", answers: ["¿Cuyo?", "¿Cómo?", "¿Qué?", "¿A qué hora?"], correctAnswerIndex: 1, sound: "how"),
        Question(interrogative: "How much?", transcriotion: "[haʊ mʌʧ]", answers: ["¿Cuál?", "¿Cuándo?", "¿Cuánto?", "¿Con quién?"], correctAnswerIndex: 2, sound: "howMuch"),
        Question(interrogative: "Why?", transcriotion: "[waɪ]", answers: ["¿Dónde?", "¿Quién?", "¿Cuánto tiempo?", "¿Por qué?"], correctAnswerIndex: 3, sound: "why"),
        Question(interrogative: "Whose?", transcriotion: "[huːz]", answers: ["¿Cuyo?", "¿Qué?", "¿Cómo?", "¿Por qué?"], correctAnswerIndex: 0, sound: "whose"),
        Question(interrogative: "Which?", transcriotion: "[wɪʧ]", answers: ["¿A qué hora?", "¿Cuál?", "¿Cuándo?", "¿Con quién?"], correctAnswerIndex: 1, sound: "which"),
        Question(interrogative: "How long?", transcriotion: "[haʊ lɒŋ]", answers: ["¿Dónde?", "¿Quién?", "¿Cuánto tiempo?", "¿Cuánto?"], correctAnswerIndex: 2, sound: "howLong"),
        Question(interrogative: "How often?", transcriotion: "[haʊ ˈɒf(t)ən]", answers: ["¿Cuyo?", "¿Qué?", "¿Cómo?", "¿Con qué frecuencia?"], correctAnswerIndex: 3, sound: "howOften"),
        Question(interrogative: "With whom?", transcriotion: "[wɪð huːm]", answers: ["¿Con quién?", "¿Cuál?", "¿Cuándo?", "¿A qué hora?"], correctAnswerIndex: 0, sound: "withWhom"),
        Question(interrogative: "By what time?", transcriotion: "[baɪ wɒt taɪm]", answers: ["¿Dónde?", "¿A qué hora?", "¿Quién?", "¿Por qué?"], correctAnswerIndex: 1, sound: "byWhatTime")
    ]
    
    let color = [
        Question(interrogative: "Red", transcriotion: "[red]", answers: ["Rojo", "Rosa", "Marrón", "Verde"], correctAnswerIndex: 0, sound: "red"),
        Question(interrogative: "Orange", transcriotion: "[ˈɒrɪnʤ]", answers: ["Azul", "Naranja", "Gris", "Blanco"], correctAnswerIndex: 1, sound: "orange"),
        Question(interrogative: "Yellow", transcriotion: "[ˈjeləʊ]", answers: ["Negro", "Púrpura", "Amarillo", "Oscuro"], correctAnswerIndex: 2, sound: "yellow"),
        Question(interrogative: "Green", transcriotion: "[griːn]", answers: ["Rojo", "Rosa", "Marrón", "Verde"], correctAnswerIndex: 3, sound: "green"),
        Question(interrogative: "Blue", transcriotion: "[bluː]", answers: ["Azul", "Naranja", "Gris", "Blanco"], correctAnswerIndex: 0, sound: "blue"),
        Question(interrogative: "Purple", transcriotion: "[pɜːpl]", answers: ["Negro", "Púrpura", "Amarillo", "Oscuro"], correctAnswerIndex: 1, sound: "purple"),
        Question(interrogative: "Brown", transcriotion: "[braʊn]", answers: ["Rojo", "Rosa", "Marrón", "Verde"], correctAnswerIndex: 2, sound: "brown"),
        Question(interrogative: "White", transcriotion: "[waɪt]", answers: ["Azul", "Naranja", "Gris", "Blanco"], correctAnswerIndex: 3, sound: "white"),
        Question(interrogative: "Black", transcriotion: "[blæk]", answers: ["Negro", "Púrpura", "Amarillo", "Oscuro"], correctAnswerIndex: 0, sound: "black"),
        Question(interrogative: "Pink", transcriotion: "[pɪŋk]", answers: ["Rojo", "Rosa", "Marrón", "Verde"], correctAnswerIndex: 1, sound: "pink"),
        Question(interrogative: "Gray", transcriotion: "[greɪ]", answers: ["Azul", "Naranja", "Gris", "Blanco"], correctAnswerIndex: 2, sound: "gray"),
        Question(interrogative: "Dark", transcriotion: "[dɑːk]", answers: ["Negro", "Púrpura", "Amarillo", "Oscuro"], correctAnswerIndex: 3, sound: "dark"),
        Question(interrogative: "Light", transcriotion: "[laɪt]", answers: ["Luminoso", "Rojo", "Marrón", "Verde"], correctAnswerIndex: 0, sound: "light")
    ]
    
    let geometricShape = [
        Question(interrogative: "Circle", transcriotion: "[sɜːkl]", answers: ["Círculo", "Punto", "Pirámide", "Ancho"], correctAnswerIndex: 0, sound: "circle"),
        Question(interrogative: "Triangle", transcriotion: "[ˈtraɪæŋgl]", answers: ["Esquina", "Triángulo", "Altura", "Cubo"], correctAnswerIndex: 1, sound: "triangle"),
        Question(interrogative: "Square", transcriotion: "[skweə]", answers: ["Recta", "Tamaño", "Plaza", "Estrella"], correctAnswerIndex: 2, sound: "square"),
        Question(interrogative: "Point", transcriotion: "[pɔɪnt]", answers: ["Punto", "Círculo", "Pirámide", "Ancho"], correctAnswerIndex: 0, sound: "point"),
        Question(interrogative: "Angle", transcriotion: "[æŋgl]", answers: ["Triángulo", "Esquina", "Altura", "Cubo"], correctAnswerIndex: 1, sound: "angle"),
        Question(interrogative: "Size", transcriotion: "[saɪz]", answers: ["Recta", "Plaza", "Tamaño", "Estrella"], correctAnswerIndex: 2, sound: "size"),
        Question(interrogative: "Width", transcriotion: "[wɪdθ]", answers: ["Círculo", "Punto", "Pirámide", "Ancho"], correctAnswerIndex: 3, sound: "width"),
        Question(interrogative: "Height", transcriotion: "[haɪt]", answers: ["Altura", "Triángulo", "Esquina", "Cubo"], correctAnswerIndex: 0, sound: "height"),
        Question(interrogative: "Line", transcriotion: "[laɪn]", answers: ["Estrella", "Recta", "Plaza", "Tamaño"], correctAnswerIndex: 1, sound: "line"),
        Question(interrogative: "Pyramid", transcriotion: "[ˈpɪrəmɪd]", answers: ["Círculo", "Punto", "Pirámide", "Ancho"], correctAnswerIndex: 2, sound: "pyramid"),
        Question(interrogative: "Cube", transcriotion: "[kjuːb]", answers: ["Altura", "Triángulo", "Esquina", "Cubo"], correctAnswerIndex: 3, sound: "cube"),
        Question(interrogative: "Star", transcriotion: "[stɑː]", answers: ["Estrella", "Recta", "Plaza", "Tamaño"], correctAnswerIndex: 0, sound: "star"),
        Question(interrogative: "Rhombus", transcriotion: "[ˈrɒmbəs]", answers: ["Círculo", "Rombo", "Punto", "Ancho"], correctAnswerIndex: 1, sound: "rhombus"),
        Question(interrogative: "Oval", transcriotion: "[ˈəʊvəl]", answers: ["Altura", "Triángulo", "Oval", "Esquina"], correctAnswerIndex: 2, sound: "oval"),
        Question(interrogative: "Rectangle", transcriotion: "[ˈrektæŋgl]", answers: ["Estrella", "Tamaño", "Plaza", "Rectángulo"], correctAnswerIndex: 3, sound: "rectangle"),
        Question(interrogative: "Cone", transcriotion: "[kəʊn]", answers: ["Cono", "Círculo", "Punto", "Ancho"], correctAnswerIndex: 0, sound: "cone")
    ]
    
//MARK: - Time
    let number = [
        Question(interrogative: "Zero", transcriotion: "[ˈzɪərəʊ]", answers: ["Cero", "Nueve", "Seis", "Tres"], correctAnswerIndex: 0, sound: "zero"),
        Question(interrogative: "One", transcriotion: "[wʌn]", answers: ["Cuatro", "Uno", "Diez", "Siete"], correctAnswerIndex: 1, sound: "one"),
        Question(interrogative: "Two", transcriotion: "[tuː]", answers: ["Ocho", "Cinco", "Dos", "Nueve"], correctAnswerIndex: 2, sound: "two"),
        Question(interrogative: "Three", transcriotion: "[θriː]", answers: ["Nueve", "Cero", "Seis", "Tres"], correctAnswerIndex: 3, sound: "three"),
        Question(interrogative: "Four", transcriotion: "[fɔː]", answers: ["Cuatro", "Uno", "Diez", "Siete"], correctAnswerIndex: 0, sound: "four"),
        Question(interrogative: "Five", transcriotion: "[faɪv]", answers: ["Ocho", "Cinco", "Dos", "Tres"], correctAnswerIndex: 1, sound: "five"),
        Question(interrogative: "Six", transcriotion: "[sɪks]", answers: ["Nueve", "Cero", "Seis", "Tres"], correctAnswerIndex: 2, sound: "six"),
        Question(interrogative: "Seven", transcriotion: "[sevn]", answers: ["Cuatro", "Uno", "Diez", "Siete"], correctAnswerIndex: 3, sound: "seven"),
        Question(interrogative: "Eight", transcriotion: "[eɪt]", answers: ["Ocho", "Cinco", "Dos", "Seis"], correctAnswerIndex: 0, sound: "eight"),
        Question(interrogative: "Nine", transcriotion: "[naɪn]", answers: ["Cero", "Nueve", "Seis", "Tres"], correctAnswerIndex: 1, sound: "nine"),
        Question(interrogative: "Ten", transcriotion: "[ten]", answers: ["Cuatro", "Uno", "Diez", "Siete"], correctAnswerIndex: 2, sound: "ten")
    ]
    
    let numberComplex = [
        Question(interrogative: "Eleven", transcriotion: "[ɪˈlevn]", answers: ["Mil", "Diecinueve", "Quince", "Once"], correctAnswerIndex: 3, sound: "eleven"),
        Question(interrogative: "Twelve", transcriotion: "[twelv]", answers: ["Doce", "Dieciséis", "Setenta", "Cuarenta"], correctAnswerIndex: 0, sound: "twelve"),
        Question(interrogative: "Thirteen", transcriotion: "[θɜːˈtiːn]", answers: ["Cincuenta", "Trece", "Diecisiete", "Veintiuno"], correctAnswerIndex: 1, sound: "thirteen"),
        Question(interrogative: "Fourteen", transcriotion: "[fɔːˈtiːn]", answers: ["Sesenta", "Veintidós", "Catorce", "Dieciocho"], correctAnswerIndex: 2, sound: "fourteen"),
        Question(interrogative: "Fifteen", transcriotion: "[fɪfˈtiːn]", answers: ["Treinta", "Diecinueve", "Once", "Quince"], correctAnswerIndex: 3, sound: "fifteen"),
        Question(interrogative: "Sixteen", transcriotion: "[sɪkˈstiːn]", answers: ["Dieciséis", "Ochenta", "Veinte", "Cuarenta"], correctAnswerIndex: 0, sound: "sixteen"),
        Question(interrogative: "Seventeen", transcriotion: "[sev(ə)nˈtiːn]", answers: ["Trece", "Diecisiete", "Veintiuno", "Cincuenta"], correctAnswerIndex: 1, sound: "seventeen"),
        Question(interrogative: "Eighteen", transcriotion: "[eɪˈtiːn]", answers: ["Sesenta", "Catorce", "Dieciocho", "Veintidós"], correctAnswerIndex: 2, sound: "eighteen"),
        Question(interrogative: "Nineteen", transcriotion: "[naɪnˈtiːn]", answers: ["Treinta", "Quince", "Setenta", "Diecinueve"], correctAnswerIndex: 3, sound: "nineteen"),
        Question(interrogative: "Twenty", transcriotion: "[ˈtwentɪ]", answers: ["Veinte", "Doce", "Dieciséis", "Cuarenta"], correctAnswerIndex: 0, sound: "twenty"),
        Question(interrogative: "Twenty one", transcriotion: "[ˈtwentɪ wʌn]", answers: ["Trece", "Veintiuno", "Diecisiete", "Cincuenta"], correctAnswerIndex: 1, sound: "twentyOne"),
        Question(interrogative: "Twenty two", transcriotion: "[ˈtwentɪ tuː]", answers: ["Ochenta", "Dieciocho", "Veintidós", "Catorce"], correctAnswerIndex: 2, sound: "twentyTwo"),
        Question(interrogative: "Thirty", transcriotion: "[ˈθɜːtɪ]", answers: ["Diecinueve", "Quince", "Once", "Treinta"], correctAnswerIndex: 3, sound: "thirty"),
        Question(interrogative: "Forty", transcriotion: "[ˈfɔːtɪ]", answers: ["Cuarenta", "Doce", "Dieciséis", "Veinte"], correctAnswerIndex: 0, sound: "forty"),
        Question(interrogative: "Fifty", transcriotion: "[ˈfɪftɪ]", answers: ["Trece", "Cincuenta", "Diecisiete", "Veintiuno"], correctAnswerIndex: 1, sound: "fifty"),
        Question(interrogative: "Sixty", transcriotion: "[ˈsɪkstɪ]", answers: ["Veintidós", "Dieciocho", "Sesenta", "Catorce"], correctAnswerIndex: 2, sound: "sixty"),
        Question(interrogative: "Seventy", transcriotion: "[ˈsevntɪ]", answers: ["Diecinueve", "Treinta", "Once", "Setenta"], correctAnswerIndex: 3, sound: "seventy"),
        Question(interrogative: "Eighty", transcriotion: "[ˈeɪtɪ]", answers: ["Ochenta", "Doce", "Dieciséis", "Veinte"], correctAnswerIndex: 0, sound: "eighty"),
        Question(interrogative: "Ninety", transcriotion: "[ˈnaɪntɪ]", answers: ["Trece", "Noventa", "Diecisiete", "Veintiuno"], correctAnswerIndex: 1, sound: "ninety"),
        Question(interrogative: "Hundred", transcriotion: "[ˈhʌndrəd]", answers: ["Cuarenta", "Dieciocho", "Cien", "Catorce"], correctAnswerIndex: 2, sound: "hundred"),
        Question(interrogative: "Thousand", transcriotion: "[ˈθaʊzənd]", answers: ["Diecinueve", "Cien", "Setenta", "Mil"], correctAnswerIndex: 3, sound: "thousand"),
        Question(interrogative: "Million", transcriotion: "[ˈmɪljən]", answers: ["Un millón", "Cien", "Dieciséis", "Mil"], correctAnswerIndex: 0, sound: "million")
    ]
    
    let unitsOfTime = [
        Question(interrogative: "Time", transcriotion: "[taɪm]", answers: ["Calendario", "Año", "Día", "Tiempo"], correctAnswerIndex: 3, sound: "time"),
        Question(interrogative: "Second", transcriotion: "[ˈsekənd]", answers: ["Segundo", "Semana", "Año", "Pasado"], correctAnswerIndex: 0, sound: "second"),
        Question(interrogative: "Minute", transcriotion: "[ˈmɪnɪt]", answers: ["Reloj", "Minuto", "Mes", "Presente"], correctAnswerIndex: 1, sound: "minute"),
        Question(interrogative: "Hour", transcriotion: "[ˈaʊə]", answers: ["Segundo", "Futuro", "Hora", "Temporada"], correctAnswerIndex: 2, sound: "hour"),
        Question(interrogative: "Day", transcriotion: "[deɪ]", answers: ["Calendario", "Año", "Tiempo", "Día"], correctAnswerIndex: 3, sound: "day"),
        Question(interrogative: "Week", transcriotion: "[wiːk]", answers: ["Semana", "Segundo", "Mes", "Pasado"], correctAnswerIndex: 0, sound: "week"),
        Question(interrogative: "Month", transcriotion: "[mʌnθ]", answers: ["Reloj", "Mes", "Minuto", "Presente"], correctAnswerIndex: 1, sound: "month"),
        Question(interrogative: "Season", transcriotion: "[siːzn]", answers: ["Futuro", "Hora", "Temporada", "Minuto"], correctAnswerIndex: 2, sound: "season"),
        Question(interrogative: "Year", transcriotion: "[jɪə]", answers: ["Calendario", "Día", "Tiempo", "Año"], correctAnswerIndex: 3, sound: "year"),
        Question(interrogative: "Century", transcriotion: "[ˈsenʧərɪ]", answers: ["Siglo", "Segundo", "Semana", "Pasado"], correctAnswerIndex: 0, sound: "century"),
        Question(interrogative: "Watch", transcriotion: "[wɒʧ]", answers: ["Presente", "Reloj", "Minuto", "Mes"], correctAnswerIndex: 1, sound: "watch"),
        Question(interrogative: "Clock", transcriotion: "[klɒk]", answers: ["Futuro", "Hora", "Reloj", "Temporada"], correctAnswerIndex: 2, sound: "clock"),
        Question(interrogative: "Calendar", transcriotion: "[ˈkælɪndə]", answers: ["Año", "Día", "Tiempo", "Calendario"], correctAnswerIndex: 3, sound: "calendar"),
        Question(interrogative: "Past", transcriotion: "[pɑːst]", answers: ["Pasado", "Segundo", "Semana", "Hora"], correctAnswerIndex: 0, sound: "past"),
        Question(interrogative: "Present", transcriotion: "[preznt]", answers: ["Reloj", "Presente", "Minuto", "Mes"], correctAnswerIndex: 1, sound: "present"),
        Question(interrogative: "Future", transcriotion: "[ˈfjuːʧə]", answers: ["Presente", "Hora", "Futuro", "Temporada"], correctAnswerIndex: 2, sound: "future")
    ]
    
    let monthSeason = [
        Question(interrogative: "January", transcriotion: "[ˈʤænjʊərɪ]", answers: ["Enero", "Octubre", "Julio", "Abril"], correctAnswerIndex: 0, sound: "january"),
        Question(interrogative: "February", transcriotion: "[ˈfebrʊərɪ]", answers: ["Mayo", "Febrero", "Noviembre", "Agosto"], correctAnswerIndex: 1, sound: "february"),
        Question(interrogative: "March", transcriotion: "[mɑːʧ]", answers: ["Setiembre", "Junio", "Marzo", "Diciembre"], correctAnswerIndex: 2, sound: "march"),
        Question(interrogative: "April", transcriotion: "[ˈeɪprəl]", answers: ["Enero", "Octubre", "Julio", "Abril"], correctAnswerIndex: 3, sound: "april"),
        Question(interrogative: "May", transcriotion: "[meɪ]", answers: ["Mayo", "Febrero", "Noviembre", "Agosto"], correctAnswerIndex: 0, sound: "may"),
        Question(interrogative: "June", transcriotion: "[ʤuːn]", answers: ["Setiembre", "Junio", "Marzo", "Diciembre"], correctAnswerIndex: 1, sound: "june"),
        Question(interrogative: "July", transcriotion: "[ʤʊˈlaɪ]", answers: ["Enero", "Octubre", "Julio", "Abril"], correctAnswerIndex: 2, sound: "july"),
        Question(interrogative: "August", transcriotion: "[ˈɔːgəst]", answers: ["Mayo", "Febrero", "Noviembre", "Agosto"], correctAnswerIndex: 3, sound: "august"),
        Question(interrogative: "September", transcriotion: "[sepˈtembə]", answers: ["Setiembre", "Junio", "Marzo", "Diciembre"], correctAnswerIndex: 0, sound: "september"),
        Question(interrogative: "October", transcriotion: "[ɒkˈtəʊbə]", answers: ["Enero", "Octubre", "Julio", "Abril"], correctAnswerIndex: 1, sound: "october"),
        Question(interrogative: "November", transcriotion: "[nəʊˈvembə]", answers: ["Mayo", "Febrero", "Noviembre", "Agosto"], correctAnswerIndex: 2, sound: "november"),
        Question(interrogative: "December", transcriotion: "[dɪˈsembə]", answers: ["Setiembre", "Junio", "Marzo", "Diciembre"], correctAnswerIndex: 3, sound: "december"),
        Question(interrogative: "Winter", transcriotion: "[ˈwɪntə]", answers: ["Invierno", "Primavera", "Verano", "Otoño"], correctAnswerIndex: 0, sound: "winter"),
        Question(interrogative: "Spring", transcriotion: "[sprɪŋ]", answers: ["Invierno", "Primavera", "Verano", "Otoño"], correctAnswerIndex: 1, sound: "spring"),
        Question(interrogative: "Summer", transcriotion: "[ˈsʌmə]", answers: ["Invierno", "Primavera", "Verano", "Otoño"], correctAnswerIndex: 2, sound: "summer"),
        Question(interrogative: "Autumn", transcriotion: "[ˈɔːtəm]", answers: ["Invierno", "Primavera", "Verano", "Otoño"], correctAnswerIndex: 3, sound: "autumn")
    ]
    
    let day = [
        Question(interrogative: "Day", transcriotion: "[deɪ]", answers: ["Día", "Mediodía", "Mañana", "Tarde"], correctAnswerIndex: 0, sound: "day"),
        Question(interrogative: "Morning", transcriotion: "[ˈmɔːnɪŋ]", answers: ["Noche", "Mañana", "Tarde", "Medianoche"], correctAnswerIndex: 1, sound: "morning"),
        Question(interrogative: "Afternoon", transcriotion: "[ˈpæŋkeɪk]", answers: ["Noche", "Día", "Mediodía", "Mañana"], correctAnswerIndex: 2, sound: "afternoon"),
        Question(interrogative: "Evening", transcriotion: "[ˈiːvnɪŋ]", answers: ["Día", "Noche", "Medianoche", "Tarde"], correctAnswerIndex: 3, sound: "evening"),
        Question(interrogative: "Night", transcriotion: "[naɪt]", answers: ["Noche", "Mediodía", "Día", "Tarde"], correctAnswerIndex: 0, sound: "night"),
        Question(interrogative: "Midnight", transcriotion: "[ˈmɪdnaɪt]", answers: ["De la mañana", "Medianoche", "Día", "Noche"], correctAnswerIndex: 1, sound: "midnight"),
        Question(interrogative: "a.m.", transcriotion: "[ˈmɪdnaɪt]", answers: ["Tarde", "De la tarde", "De la mañana", "Medianoche"], correctAnswerIndex: 2, sound: "am"),
        Question(interrogative: "p.m.", transcriotion: "[ˈmɪdnaɪt]", answers: ["De la tarde", "De la mañana", "Mediodía", "Noche"], correctAnswerIndex: 0, sound: "pm"),
        Question(interrogative: "Yesterday", transcriotion: "[ˈjestədɪ]", answers: ["Ahora", "Mañana", "Ayer", "Hoy"], correctAnswerIndex: 2, sound: "yesterday"),
        Question(interrogative: "Today", transcriotion: "[təˈdeɪ]", answers: ["Ahora", "Mañana", "Ayer", "Hoy"], correctAnswerIndex: 3, sound: "today"),
        Question(interrogative: "Now", transcriotion: "[naʊ]", answers: ["Ahora", "Mañana", "Ayer", "Hoy"], correctAnswerIndex: 0, sound: "now"),
        Question(interrogative: "Tomorrow", transcriotion: "[təˈmɒrəʊ]", answers: ["Ahora", "Mañana", "Ayer", "Hoy"], correctAnswerIndex: 1, sound: "tomorrow"),
        Question(interrogative: "Monday", transcriotion: "[ˈmʌndɪ]", answers: ["Miércoles", "Viernes", "Lunes", "Domingo"], correctAnswerIndex: 2, sound: "monday"),
        Question(interrogative: "Tuesday", transcriotion: "[ˈtjuːzdɪ]", answers: ["Día", "Jueves", "Sábado", "Martes"], correctAnswerIndex: 3, sound: "tuesday"),
        Question(interrogative: "Wednesday", transcriotion: "[ˈwenzdɪ]", answers: ["Miércoles", "Viernes", "Lunes", "Domingo"], correctAnswerIndex: 0, sound: "wednesday"),
        Question(interrogative: "Thursday", transcriotion: "[ˈθɜːzdɪ]", answers: ["Noche", "Jueves", "Sábado", "Martes"], correctAnswerIndex: 1, sound: "thursday"),
        Question(interrogative: "Friday", transcriotion: "[ˈfraɪdɪ]", answers: ["Miércoles", "Lunes", "Viernes", "Domingo"], correctAnswerIndex: 2, sound: "friday"),
        Question(interrogative: "Saturday", transcriotion: "[ˈsætədɪ]", answers: ["Mediodía", "Jueves", "Martes", "Sábado"], correctAnswerIndex: 3, sound: "saturday"),
        Question(interrogative: "Sunday", transcriotion: "[ˈsʌndɪ]", answers: ["Domingo", "Miércoles", "Lunes", "Viernes"], correctAnswerIndex: 0, sound: "sunday")
    ]
    
    let timePeriods = [
        Question(interrogative: "Always", transcriotion: "[ˈɔːlw(e)ɪz]", answers: ["Siempre", "Pronto", "Durante", "Todavîa"], correctAnswerIndex: 0, sound: "always"),
        Question(interrogative: "Never", transcriotion: "[ˈnevə]", answers: ["Antes", "Nunca", "Habitualmente", "Entonces"], correctAnswerIndex: 1, sound: "never"),
        Question(interrogative: "Often", transcriotion: "[ˈɒf(t)ən]", answers: ["Desde", "Ya", "A menudo", "Próximo"], correctAnswerIndex: 2, sound: "often"),
        Question(interrogative: "Sometimes", transcriotion: "[ˈsʌmtaɪmz]", answers: ["Último", "Después", "Temprano", "A veces"], correctAnswerIndex: 3, sound: "sometimes"),
        Question(interrogative: "Soon", transcriotion: "[suːn]", answers: ["Siempre", "Pronto", "Durante", "Todavîa"], correctAnswerIndex: 1, sound: "soon"),
        Question(interrogative: "Usually", transcriotion: "[ˈjuːʒʊəlɪ]", answers: ["Habitualmente", "Nunca", "Entonces", "Antes"], correctAnswerIndex: 0, sound: "usually"),
        Question(interrogative: "Already", transcriotion: "[ɔːlˈredɪ]", answers: ["Desde", "Ya", "Tarde", "A menudo"], correctAnswerIndex: 1, sound: "already"),
        Question(interrogative: "Just", transcriotion: "[ʤʌst]", answers: ["Próximo", "Temprano", "Después", "A veces"], correctAnswerIndex: 2, sound: "just"),
        Question(interrogative: "Yet", transcriotion: "[jet]", answers: ["Siempre", "Pronto", "Durante", "Todavîa"], correctAnswerIndex: 3, sound: "yet"),
        Question(interrogative: "Then", transcriotion: "[ðen]", answers: ["Entonces", "Nunca", "Habitualmente", "Antes"], correctAnswerIndex: 0, sound: "then"),
        Question(interrogative: "After", transcriotion: "[ˈɑːftə]", answers: ["Desde", "Después", "Ya", "A menudo"], correctAnswerIndex: 1, sound: "after"),
        Question(interrogative: "During", transcriotion: "[ˈdjʊərɪŋ]", answers: ["Temprano", "Después", "Durante", "A veces"], correctAnswerIndex: 2, sound: "during"),
        Question(interrogative: "For", transcriotion: "[fɔː]", answers: ["Siempre", "Pronto", "Último", "Durante"], correctAnswerIndex: 3, sound: "for"),
        Question(interrogative: "Before", transcriotion: "[bɪˈfɔː]", answers: ["Antes", "Nunca", "Habitualmente", "Entonces"], correctAnswerIndex: 0, sound: "before"),
        Question(interrogative: "Since", transcriotion: "[sɪns]", answers: ["Tarde", "Desde", "Ya", "A menudo"], correctAnswerIndex: 1, sound: "since"),
        Question(interrogative: "Early", transcriotion: "[ˈɜːlɪ]", answers: ["Durante", "Después", "Temprano", "A veces"], correctAnswerIndex: 2, sound: "early"),
        Question(interrogative: "Last", transcriotion: "[lɑːst]", answers: ["Siempre", "Pronto", "Todavîa", "Último"], correctAnswerIndex: 3, sound: "last"),
        Question(interrogative: "Late", transcriotion: "[leɪt]", answers: ["Tarde", "Nunca", "Habitualmente", "Entonces"], correctAnswerIndex: 0, sound: "late"),
        Question(interrogative: "Next", transcriotion: "[nekst]", answers: ["Desde", "Próximo", "Ya", "A menudo"], correctAnswerIndex: 1, sound: "next"),
        Question(interrogative: "Ago", transcriotion: "[əˈgəʊ]", answers: ["Durante", "Después", "Hace", "A veces"], correctAnswerIndex: 2, sound: "ago")
    ]
    
//MARK: - Person
    let person = [
        Question(interrogative: "Person", transcriotion: "[pɜːsn]", answers: ["Человек", "Национальность", "Женщина", "Фамилия"], correctAnswerIndex: 0, sound: "person"),
        Question(interrogative: "Soul", transcriotion: "[səʊl]", answers: ["Смерть", "Душа", "Имя", "Жизнь"], correctAnswerIndex: 1, sound: "soul"),
        Question(interrogative: "Life", transcriotion: "[laɪf]", answers: ["Смерть", "Возраст", "Жизнь", "Ребёнок"], correctAnswerIndex: 2, sound: "life"),
        Question(interrogative: "Death", transcriotion: "[deθ]", answers: ["Душа", "Фамилия", "Жизнь", "Смерть"], correctAnswerIndex: 3, sound: "death"),
        Question(interrogative: "Name", transcriotion: "[neɪm]", answers: ["Человек", "Имя", "Фамилия", "Пол"], correctAnswerIndex: 1, sound: "name"),
        Question(interrogative: "Surname", transcriotion: "[ˈsɜːneɪm]", answers: ["Отчество", "Имя", "Фамилия", "Возраст"], correctAnswerIndex: 2, sound: "surname"),
        Question(interrogative: "Patronymic", transcriotion: "[pætrəˈnɪmɪk]", answers: ["Жизнь", "Фамилия", "Национальность", "Отчество"], correctAnswerIndex: 3, sound: "patronymic"),
        Question(interrogative: "Age", transcriotion: "[eɪʤ]", answers: ["Возраст", "Душа", "Пол", "Имя"], correctAnswerIndex: 0, sound: "age"),
        Question(interrogative: "Nationality", transcriotion: "[næʃəˈnælɪtɪ]", answers: ["Отчество", "Национальность", "Фамилия", "Человек"], correctAnswerIndex: 1, sound: "nationality"),
        Question(interrogative: "Sex", transcriotion: "[seks]", answers: ["Пол", "Возраст", "Имя", "Жизнь"], correctAnswerIndex: 0, sound: "sex"),
        Question(interrogative: "Baby", transcriotion: "[ˈbeɪbɪ]", answers: ["Подросток", "Младенец", "Ребёнок", "Мальчик"], correctAnswerIndex: 1, sound: "baby"),
        Question(interrogative: "Сhild", transcriotion: "[ʧaɪld]", answers: ["Ребёнок", "Младенец", "Подросток", "Детство"], correctAnswerIndex: 0, sound: "child"),
        Question(interrogative: "Childhood", transcriotion: "[ˈʧaɪldhʊd]", answers: ["Мальчик", "Возраст", "Молодёжь", "Детство"], correctAnswerIndex: 3, sound: "childhood"),
        Question(interrogative: "Teenager", transcriotion: "[ˈtiːneɪʤə]", answers: ["Молодёжь", "Мальчик", "Подросток", "Девушка"], correctAnswerIndex: 2, sound: "teenager"),
        Question(interrogative: "Youth", transcriotion: "[jʊθ]", answers: ["Старость", "Подросток", "Детство", "Молодёжь"], correctAnswerIndex: 3, sound: "youth"),
        Question(interrogative: "Boy", transcriotion: "[bɔɪ]", answers: ["Мужчина", "Девушка", "Подросток", "Мальчик"], correctAnswerIndex: 3, sound: "boy"),
        Question(interrogative: "Girl", transcriotion: "[gɜːl]", answers: ["Девушка", "Ребёнок", "Женщина", "Мужчина"], correctAnswerIndex: 0, sound: "girl"),
        Question(interrogative: "Man", transcriotion: "[mæn]", answers: ["Парень", "Мужчина", "Женщина", "Возраст"], correctAnswerIndex: 1, sound: "man"),
        Question(interrogative: "Woman", transcriotion: "[ˈwʊmən]", answers: ["Мужчина", "Девушка", "Женщина", "Старик"], correctAnswerIndex: 2, sound: "woman"),
        Question(interrogative: "Old man", transcriotion: "[əʊld mæn]", answers: ["Пожилая женщина", "Старик", "Мужчина", "Возраст"], correctAnswerIndex: 1, sound: "oldMan"),
        Question(interrogative: "Old woman", transcriotion: " [əʊld ˈwʊmən]", answers: ["Женщина", "Возраст", "Пожилая женщина", "Девушка"], correctAnswerIndex: 2, sound: "oldWoman")
        ]
        let family = [
        Question(interrogative: "Family", transcriotion: "[ˈfæm(ə)lɪ]", answers: ["Семья", "Дуг", "Отец", "Родственник"], correctAnswerIndex: 0, sound: "family"),
        Question(interrogative: "Relative", transcriotion: "[ˈrelətɪv]", answers: ["Семья", "Родители", "Родственник", "Дочь"], correctAnswerIndex: 2, sound: "relative"),
        Question(interrogative: "Father", transcriotion: "[ˈfɑːðə]", answers: ["Мама", "Отец", "Дедушка", "Муж"], correctAnswerIndex: 1, sound: "father"),
        Question(interrogative: "Mother", transcriotion: "[ˈmʌðə]", answers: ["Отец", "Пара", "Мама", "Бабушка"], correctAnswerIndex: 2, sound: "mother"),
        Question(interrogative: "Parent", transcriotion: "[ˈpe(ə)rənt]", answers: ["Мама", "Отец", "Родственник", "Родитель"], correctAnswerIndex: 3, sound: "parent"),
        Question(interrogative: "Son", transcriotion: "[sʌn]", answers: ["Сын", "Дочь", "Внук", "Солнце"], correctAnswerIndex: 0, sound: "son"),
        Question(interrogative: "Daughter", transcriotion: "[ˈdɔːtə]", answers: ["Сын", "Дочь", "Брат", "Внучка"], correctAnswerIndex: 1, sound: "daughter"),
        Question(interrogative: "Twins", transcriotion: "[twɪnz]", answers: ["Близнецы", "Любимый парень", "Друг", "Двоюродный брат"], correctAnswerIndex: 0, sound: "twins"),
        Question(interrogative: "Brother", transcriotion: " [ˈbrʌðə]", answers: ["Двоюродная сестра", "Сестра", "Брат", "Невеста"], correctAnswerIndex: 2, sound: "brother"),
        Question(interrogative: "Sister", transcriotion: "[ˈsɪstə]", answers: ["Брат", "Двоюродный брат", "Тётя", "Сестра"], correctAnswerIndex: 3, sound: "sister"),
        Question(interrogative: "Cousin", transcriotion: "[kʌzn]", answers: ["Брат", "Сестра", "Друг", "Двоюродная сестра"], correctAnswerIndex: 3, sound: "cousin"),
        Question(interrogative: "Boyfriend", transcriotion: "[ˈbɔɪfrend]", answers: ["Любимый парень", "Друг", "Брат", "Жених"], correctAnswerIndex: 0, sound: "boyfriend"),
        Question(interrogative: "Girlfriend", transcriotion: "[ˈɡɜːlfrɛnd]", answers: ["Сестра", "Любимая девушка", "Друг", "Невеста"], correctAnswerIndex: 1, sound: "girlfriend"),
        Question(interrogative: "Groom", transcriotion: "[grum]", answers: ["Невеста", "Муж", "Жених", "Жена"], correctAnswerIndex: 2, sound: "groom"),
        Question(interrogative: "Bride", transcriotion: "[braɪd]", answers: ["Жена", "Жених", "Муж", "Невеста"], correctAnswerIndex: 3, sound: "bride"),
        Question(interrogative: "Husband", transcriotion: "[ˈhʌzbənd]", answers: ["Муж", "Жена", "Невеста", "Жених"], correctAnswerIndex: 0, sound: "husband"),
        Question(interrogative: "Wife", transcriotion: "[waɪf]", answers: ["Пара", "Жена", "Муж", "Невеста"], correctAnswerIndex: 1, sound: "wife"),
        Question(interrogative: "Couple", transcriotion: "[kʌpl]", answers: ["Свадьба", "Холостях", "Пара", "Муж"], correctAnswerIndex: 2, sound: "couple"),
        Question(interrogative: "Bachelor", transcriotion: "[ˈbæʧələ]", answers: ["Пара", "Холостяк", "Свадьба", "Невеста"], correctAnswerIndex: 1, sound: "bachelor"),
        Question(interrogative: "Wedding", transcriotion: "[ˈwedɪŋ]", answers: ["Холостяк", "Пара", "Жена", "Свадьба"], correctAnswerIndex: 3, sound: "wedding"),
        Question(interrogative: "Grandfather", transcriotion: "[ˈgrændfɑːðə]", answers: ["Прадедушка", "Отец", "Дедушка", "Бабушка"], correctAnswerIndex: 2, sound: "grandfather"),
        Question(interrogative: "Grandmother", transcriotion: "[ˈgrænmʌðə]", answers: ["Прадедушка", "Дедушка", "Внук", "Бабушка"], correctAnswerIndex: 3, sound: "grandmother"),
        Question(interrogative: "Grandson", transcriotion: "[ˈgrænsʌn]", answers: ["Внук", "Сын", "Дочь", "Дедушка"], correctAnswerIndex: 0, sound: "grandson"),
        Question(interrogative: "Granddaughter", transcriotion: "[ˈgrændɔːtə]", answers: ["Бабушка", "Внучка", "Прабабушка", "Прадедушка"], correctAnswerIndex: 1, sound: "granddaughter"),
        Question(interrogative: "Great-Grandson", transcriotion: "[greɪt-ˈgrænsʌn]", answers: ["Внучка", "Правнук", "Дедушка", "Бабушка"], correctAnswerIndex: 1, sound: "greatGrandson"),
        Question(interrogative: "Uncle", transcriotion: "[ʌŋkl]", answers: ["Тётя", "Жена", "Дядя", "Отец"], correctAnswerIndex: 2, sound: "uncle"),
        Question(interrogative: "Aunt", transcriotion: "[ɑːnt]", answers: ["Жених", "Сын", "Дядя", "Тётя"], correctAnswerIndex: 3, sound: "aunt"),
        Question(interrogative: "Friend", transcriotion: "[frend]", answers: ["Друг", "Отец", "Дядя", "Семья"], correctAnswerIndex: 0, sound: "friend")
        ]
        let body = [
        Question(interrogative: "Body", transcriotion: "[ˈbɒdɪ]", answers: ["Тело", "Голова", "Шея", "Спина"], correctAnswerIndex: 0, sound: "body"),
        Question(interrogative: "Head", transcriotion: "[hed]", answers: ["Волосы", "Голова", "Бедро", "Кость"], correctAnswerIndex: 1, sound: "head"),
        Question(interrogative: "Hair", transcriotion: "[heə]", answers: ["Ухо", "Голова", "Волосы", "Бедро"], correctAnswerIndex: 2, sound: "hair"),
        Question(interrogative: "Ear", transcriotion: "[ɪə]", answers: ["Брось", "Глаз", "Волосы", "Ухо"], correctAnswerIndex: 3, sound: "ear"),
        Question(interrogative: "Eyebrow", transcriotion: "[ˈaɪbraʊ]", answers: ["Бровь", "Глаз", "Ухо", "Голова"], correctAnswerIndex: 0, sound: "eyebrow"),
        Question(interrogative: "Eye", transcriotion: "[aɪ]", answers: ["Ухо", "Глаз", "Бровь", "Губа"], correctAnswerIndex: 1, sound: "eye"),
        Question(interrogative: "Nose", transcriotion: "[nəʊz]", answers: ["Зуб", "Рот", "Нос", "Рука"], correctAnswerIndex: 2, sound: "nose"),
        Question(interrogative: "Mouth", transcriotion: "[maʊθ]", answers: ["Нога", "Губа", "Нос", "Рот"], correctAnswerIndex: 3, sound: "mouth"),
        Question(interrogative: "Lip", transcriotion: "[lɪp]", answers: ["Губа", "Язык", "Щека", "Живот"], correctAnswerIndex: 0, sound: "lip"),
        Question(interrogative: "Tongue", transcriotion: "[tʌŋ]", answers: ["Зуб", "Язык", "Ухо", "Шея"], correctAnswerIndex: 1, sound: "tongue"),
        Question(interrogative: "Tooth", transcriotion: "[tuːθ]", answers: ["Язык", "Череп", "Зуб", "Щека"], correctAnswerIndex: 2, sound: "tooth"),
        Question(interrogative: "Cheek", transcriotion: "[ʧiːk]", answers: ["Шея", "Грудь", "Волосы", "Щека"], correctAnswerIndex: 3, sound: "cheek"),
        Question(interrogative: "Neck", transcriotion: "[nek]", answers: ["Шея", "Щека", "Ноготь", "Нос"], correctAnswerIndex: 0, sound: "neck"),
        Question(interrogative: "Shoulder", transcriotion: "[ˈʃəʊldə]", answers: ["Рука", "Рука (кисть)", "Плечо", "Палец"], correctAnswerIndex: 2, sound: "shoulder"),
        Question(interrogative: "Arm", transcriotion: "[ɑːm]", answers: ["Нога", "Ладонь", "Палец", "Рука"], correctAnswerIndex: 3, sound: "arm"),
        Question(interrogative: "Hand", transcriotion: "[hænd]", answers: ["Рука (кисть)", "Нога", "Волосы", "Голова"], correctAnswerIndex: 0, sound: "hand"),
        Question(interrogative: "Finger", transcriotion: "[ˈfɪŋgə]", answers: ["Ноготь", "Палец", "Зуб", "Половые органы"], correctAnswerIndex: 1, sound: "finger"),
        Question(interrogative: "Nail", transcriotion: "[neɪl]", answers: ["Шея", "Волосы", "Ноготь", "Язык"], correctAnswerIndex: 2, sound: "nail"),
        Question(interrogative: "Chest", transcriotion: "[ʧest]", answers: ["Икра", "Грудная клетка", "Щека", "Грудь"], correctAnswerIndex: 1, sound: "chest"),
        Question(interrogative: "Breast", transcriotion: "[brest]", answers: ["Кость", "Грудная клетка", "Грудь", "Ягодицы"], correctAnswerIndex: 2, sound: "breast"),
        Question(interrogative: "Belly", transcriotion: "[ˈbelɪ]", answers: ["Спина", "Грудь", "Кость", "Живот"], correctAnswerIndex: 3, sound: "belly"),
        Question(interrogative: "Back", transcriotion: "[bæk]", answers: ["Спина", "Голова", "Живот", "Грудь"], correctAnswerIndex: 0, sound: "back"),
        Question(interrogative: "Buttocks", transcriotion: "[ˈbʌtəks]", answers: ["Грудная клетка", "Ягодицы", "Ступня", "Половые органы"], correctAnswerIndex: 1, sound: "buttocks"),
        Question(interrogative: "Genitals", transcriotion: "[ˈʤenɪtls]", answers: ["Грудь", "Палец", "Скелет", "Половые органы"], correctAnswerIndex: 3, sound: "genitals"),
        Question(interrogative: "Leg", transcriotion: "[leg]", answers: ["Нога", "Бедро", "Колено", "Череп"], correctAnswerIndex: 0, sound: "leg"),
        Question(interrogative: "Hip", transcriotion: "[hɪp]", answers: ["Нога", "Бедро", "Рука (кисть)", "Икра"], correctAnswerIndex: 1, sound: "hip"),
        Question(interrogative: "Knee", transcriotion: "[niː]", answers: ["Ступня", "Икра", "Колено", "Нос"], correctAnswerIndex: 2, sound: "knee"),
        Question(interrogative: "Calf", transcriotion: "[kɑːf]", answers: ["Нос", "Щека", "Ухо", "Икра"], correctAnswerIndex: 3, sound: "calf"),
        Question(interrogative: "Foot", transcriotion: "[fʊt]", answers: ["Ступня", "Нога", "Бедро", "Икра"], correctAnswerIndex: 0, sound: "foot"),
        Question(interrogative: "Skeleton", transcriotion: "[ˈskelɪtn]", answers: ["Кость", "Скелет", "Череп", "Позвоночник"], correctAnswerIndex: 1, sound: "skeleton"),
        Question(interrogative: "Skin", transcriotion: "[skɪn]", answers: ["Кожа", "Скелет", "Череп", "Голова"], correctAnswerIndex: 0, sound: "skin"),
        Question(interrogative: "Bone", transcriotion: "[bəʊn]", answers: ["Череп", "Кровь", "Кость", "Колено"], correctAnswerIndex: 2, sound: "bone"),
        Question(interrogative: "Skull", transcriotion: "[skʌl]", answers: ["Голова", "Кожа", "Кость", "Череп"], correctAnswerIndex: 3, sound: "skull")
        ]
    let feelings = [
        Question(interrogative: "Happy", transcriotion: "[ˈhæpɪ]", answers: ["Счастливый", "Радостный", "Весёлый", "Довольный"], correctAnswerIndex: 0, sound: "happy"),
        Question(interrogative: "Merry", transcriotion: "[ˈmerɪ]", answers: ["Довольный", "Влюблённый", "Весёлый", "Счастливый"], correctAnswerIndex: 2, sound: "merry"),
        Question(interrogative: "Enamored", transcriotion: "[ɪˈnæməd]", answers: ["Влюблённый", "Счастливый", "Довольный", "Весёлый"], correctAnswerIndex: 0, sound: "enamored"),
        Question(interrogative: "Angry", transcriotion: "[ˈæŋgrɪ]", answers: ["Нервный", "Сердитый", "Хмурый", "Непослушный"], correctAnswerIndex: 1, sound: "angry"),
        Question(interrogative: "Nervous", transcriotion: "[ˈnɜːvəs]", answers: ["Непослушный", "Сердитый", "Хмурый", "Нервный"], correctAnswerIndex: 3, sound: "nervous"),
        Question(interrogative: "Unhappy", transcriotion: "[ʌnˈhæpɪ]", answers: ["Грустный", "Несчастный", "Расстроенный", "Хмурый"], correctAnswerIndex: 1, sound: "unhappy"),
        Question(interrogative: "Frightened", transcriotion: "[fraɪtnd]", answers: ["Напуганный", "Грустный", "Хмурый", "Несчастный"], correctAnswerIndex: 0, sound: "frightened"),
        Question(interrogative: "Sad", transcriotion: "[sæd]", answers: ["Несчастный", "Грустный", "Расстроенный", "Хмурый"], correctAnswerIndex: 1, sound: "sad"),
        Question(interrogative: "Amazed", transcriotion: "[əˈmeɪzd]", answers: ["Заинтересованный", "Уверенный", "Удивлённый", "Взволнованный"], correctAnswerIndex: 2, sound: "amazed"),
        Question(interrogative: "Assured", transcriotion: "[əˈʃʊəd]", answers: ["Осторожный", "Уставший", "Уверенный", "Спокойный"], correctAnswerIndex: 2, sound: "assured"),
        Question(interrogative: "Calm", transcriotion: "[kɑːm]", answers: ["Спокойный", "Тихий", "Скучающий", "Одинокий"], correctAnswerIndex: 0, sound: "calm"),
        Question(interrogative: "Quiet", transcriotion: "[ˈkwaɪət]", answers: ["Скучающий", "Тихий", "Спокойный", "Напуганный"], correctAnswerIndex: 1, sound: "quiet"),
        Question(interrogative: "Lonely", transcriotion: "[ˈləʊnlɪ]", answers: ["Расстроенный", "Ленивый", "Одинокий", "Скучающий"], correctAnswerIndex: 2, sound: "lonely"),
        Question(interrogative: "Tired", transcriotion: "[ˈtaɪəd]", answers: ["Спокойный", "Скучающий", "Смущённый", "Уставший"], correctAnswerIndex: 3, sound: "tired"),
        Question(interrogative: "Bored", transcriotion: "[bɔːd]", answers: ["Скучающий", "Сумасшедший", "Осторожный", "Смущённый"], correctAnswerIndex: 0, sound: "bored"),
        Question(interrogative: "Crazy", transcriotion: "[ˈkreɪzɪ]", answers: ["Безумный", "Сумасшедший", "Расстроенный", "Глупый"], correctAnswerIndex: 1, sound: "crazy"),
        Question(interrogative: "Mad", transcriotion: "[mæd]", answers: ["Расстроенный", "Сумасшедший", "Безумный", "Ужасный"], correctAnswerIndex: 2, sound: "mad"),
        Question(interrogative: "Terrible", transcriotion: "[ˈterəbl]", answers: ["Безумный", "Глупый", "Сумасшедший", "Ужасный"], correctAnswerIndex: 3, sound: "terrible"),
        Question(interrogative: "Silly", transcriotion: "[ˈsɪlɪ]", answers: ["Глупый", "Ленивый", "Расстроенный", "Смущённый"], correctAnswerIndex: 0, sound: "silly"),
        Question(interrogative: "Lazy", transcriotion: "[ˈleɪzɪ]", answers: ["Безумный", "Ленивый", "Расстроенный", "Глупый"], correctAnswerIndex: 1, sound: "lazy")
    ]
    let appearance = [
        Question(interrogative: "Appearance", transcriotion: "[əˈpɪərəns]", answers: ["Внешность", "Привлекательный", "Атлетичный", "Фигура"], correctAnswerIndex: 0, sound: "appearance"),
        Question(interrogative: "Figure", transcriotion: "[ˈfɪgə]", answers: ["Внешность", "Фигура", "Рост", "Сильный"], correctAnswerIndex: 1, sound: "figure"),
        Question(interrogative: "Hairstyle", transcriotion: "[ˈheəstaɪl]", answers: ["Цвет лица", "Вес", "Прическа", "Низкий"], correctAnswerIndex: 2, sound: "hairstyle"),
        Question(interrogative: "Complexion", transcriotion: "[kəmˈplekʃn]", answers: ["Цвет волос", "Внешность", "Обычный", "Цвет лица"], correctAnswerIndex: 3, sound: "complexion"),
        Question(interrogative: "Height", transcriotion: "[haɪt]", answers: ["Рост", "Вес", "Крупный", "Хорошенький"], correctAnswerIndex: 0, sound: "heightPerson"),
        Question(interrogative: "Weight", transcriotion: "[weɪt]", answers: ["Рост", "Вес", "Низкий", "Атлетичный"], correctAnswerIndex: 1, sound: "weight"),
        Question(interrogative: "Tall", transcriotion: "[tɔːl]", answers: ["Толстый", "Милый", "Высокий", "Крупный"], correctAnswerIndex: 2, sound: "tall"),
        Question(interrogative: "Short", transcriotion: "[ʃɔːt]", answers: ["Сильный", "Стройный", "Худой", "Низкий"], correctAnswerIndex: 3, sound: "short"),
        Question(interrogative: "Slim", transcriotion: "[slɪm]", answers: ["Стройный", "Сильный", "Низкий", "Худой"], correctAnswerIndex: 0, sound: "slim"),
        Question(interrogative: "Skinny", transcriotion: "[ˈskɪnɪ]", answers: ["Сильный", "Худой", "Низкий", "Стройный"], correctAnswerIndex: 1, sound: "skinny"),
        Question(interrogative: "Weak", transcriotion: "[wiːk]", answers: ["Сильный", "Вес", "Слабый", "Прекрасный"], correctAnswerIndex: 2, sound: "weak"),
        Question(interrogative: "Plump", transcriotion: "[plʌmp]", answers: ["Крупный", "Толстый", "Сильный", "Полный"], correctAnswerIndex: 3, sound: "plump"),
        Question(interrogative: "Obese", transcriotion: "[əʊˈbiːs]", answers: ["Толстый", "Полный", "Крупный", "Атлетичный"], correctAnswerIndex: 0, sound: "obese"),
        Question(interrogative: "Heavy", transcriotion: "[ˈhevɪ]", answers: ["Крупный", "Худой", "Слабый", "Низкий"], correctAnswerIndex: 0, sound: "heavy"),
        Question(interrogative: "Athletic", transcriotion: "[æθˈletɪk]", answers: ["Очаровательный", "Красивый", "Атлетичный", "Сильный"], correctAnswerIndex: 2, sound: "athletic"),
        Question(interrogative: "Strong", transcriotion: "[strɒŋ]", answers: ["Хорошая форма", "Атлетичный", "Слабый", "Сильный"], correctAnswerIndex: 3, sound: "strong"),
        Question(interrogative: "Good shape", transcriotion: "[gʊd ʃeɪp]", answers: ["Плохая форма", "Хорошая форма", "Хорошенький", "Обычный"], correctAnswerIndex: 1, sound: "goodShape"),
        Question(interrogative: "Charming", transcriotion: "[ˈʧɑːmɪŋ]", answers: ["Очаровательный", "Цвет волос", "Прекрасный", "Обычный"], correctAnswerIndex: 0, sound: "charming"),
        Question(interrogative: "Beautiful", transcriotion: "[ˈbjuːtɪf(ə)l]", answers: ["Милый", "Фигура", "Красивый", "Хорошенький"], correctAnswerIndex: 2, sound: "beautiful"),
        Question(interrogative: "Common", transcriotion: "[ˈkɒmən]", answers: ["Низкий", "Обычный", "Худой", "Сильный"], correctAnswerIndex: 1, sound: "common"),
        Question(interrogative: "Ugly", transcriotion: "[ˈʌglɪ]", answers: ["Уродливый", "Милый", "Отвратительный", "Обычный"], correctAnswerIndex: 0, sound: "ugly")
    ]
//MARK: - Food
    let aboutFood = [
        Question(interrogative: "Food", transcriotion: "[fuːd]", answers: ["Еда", "Ужин", "Жирный", "Кушать"], correctAnswerIndex: 0, sound: "food"),
        Question(interrogative: "Meat", transcriotion: "[miːt]", answers: ["Овощи", "Ягода", "Орех", "Мясо"], correctAnswerIndex: 3, sound: "meat"),
        Question(interrogative: "Poultry", transcriotion: "[ˈpəʊltrɪ]", answers: ["Мясо птицы", "Морепродукты", "Мясо", "Жирный"], correctAnswerIndex: 0, sound: "poultry"),
        Question(interrogative: "Fish", transcriotion: "[fɪʃ]", answers: ["Овощи", "Рыба", "Ягода", "Орех"], correctAnswerIndex: 1, sound: "fish"),
        Question(interrogative: "Seafood", transcriotion: "[ˈsiːfuːd]", answers: ["Рыба", "Мясо птицы", "Морепродукты", "Еда"], correctAnswerIndex: 2, sound: "seafood"),
        Question(interrogative: "Vegatables", transcriotion: "[ˈveʤtəbəlz]", answers: ["Орех", "Рыба", "Испытывающий жажду", "Овощи"], correctAnswerIndex: 3, sound: "vegatables"),
        Question(interrogative: "Fruit", transcriotion: "[fruːt]", answers: ["Fruta", "Mariscos", "Baya", "Nuez"], correctAnswerIndex: 0, sound: "fruit"),
        Question(interrogative: "Berry", transcriotion: "[ˈberɪ]", answers: ["Рыба", "Ягода", "Мясо птицы", "Мясо"], correctAnswerIndex: 1, sound: "berry"),
        Question(interrogative: "Nut", transcriotion: "[nʌt]", answers: ["Овощи", "Ягода", "Орех", "Морепродукты"], correctAnswerIndex: 2, sound: "nut"),
        Question(interrogative: "Eat", transcriotion: "[iːt]", answers: ["Перекус", "Кушать", "Еда", "Пить"], correctAnswerIndex: 1, sound: "eat"),
        Question(interrogative: "Drink", transcriotion: "[drɪŋk]", answers: ["Agua", "Comer", "Cena", "Beber"], correctAnswerIndex: 3, sound: "drink"),
        Question(interrogative: "Appetizer", transcriotion: "[ˈæpɪtaɪzə]", answers: ["Сладкий", "Обед", "Голодный", "Закуска"], correctAnswerIndex: 3, sound: "appetizer"),
        Question(interrogative: "Snack", transcriotion: "[snæk]", answers: ["Перекус", "Пробовать", "Завтрак", "Вкусный"], correctAnswerIndex: 0, sound: "snack"),
        Question(interrogative: "Breakfast", transcriotion: "[ˈbrekfəst]", answers: ["Кушать", "Завтрак", "Солёный", "Ужин"], correctAnswerIndex: 1, sound: "breakfast"),
        Question(interrogative: "Lunch", transcriotion: "[lʌnʧ]", answers: ["Завтрак", "Жирный", "Обед", "Очень вкусный"], correctAnswerIndex: 2, sound: "lunch"),
        Question(interrogative: "Dinner", transcriotion: "[ˈdɪnə]", answers: ["Голодный", "Завтрак", "Сладкий", "Ужин"], correctAnswerIndex: 3, sound: "dinner"),
        Question(interrogative: "Hungry", transcriotion: "[ˈhʌŋgrɪ]", answers: ["Голодный", "Испытывающий жажду", "Кислый", "Ужин"], correctAnswerIndex: 0, sound: "hungry"),
        Question(interrogative: "Thirsty", transcriotion: "[ˈθɜːstɪ]", answers: ["Испытывающий жажду", "Пробовать", "Голодный", "Фрукт"], correctAnswerIndex: 0, sound: "thirsty"),
        Question(interrogative: "Taste", transcriotion: "[teɪst]", answers: ["Перекус", "Пробовать", "Вкусный", "Очень вкусный"], correctAnswerIndex: 1, sound: "taste"),
        Question(interrogative: "Bitter", transcriotion: "[ˈbɪtə]", answers: ["Острый", "Солёный", "Горький", "Сладкий"], correctAnswerIndex: 2, sound: "bitter"),
        Question(interrogative: "Delicious", transcriotion: "[dɪˈlɪʃəs]", answers: ["Закуска", "Кислый", "Ужин", "Очень вкусный"], correctAnswerIndex: 3, sound: "delicious"),
        Question(interrogative: "Fatty", transcriotion: "[ˈfætɪ]", answers: ["Жирный", "Обед", "Еда", "Приём пищи"], correctAnswerIndex: 0, sound: "fatty"),
        Question(interrogative: "Salty", transcriotion: "[ˈsɔːltɪ]", answers: ["Кислый", "Солёный", "Вкусный", "Сладкий"], correctAnswerIndex: 1, sound: "salty"),
        Question(interrogative: "Sour", transcriotion: "[ˈsaʊə]", answers: ["Испытывающий жажду", "Закуска", "Кислый", "Обед"], correctAnswerIndex: 2, sound: "sour"),
        Question(interrogative: "Spicy", transcriotion: "[ˈspaɪsɪ]", answers: ["Ужин", "Очень вкусный", "Приём пищи", "Острый"], correctAnswerIndex: 3, sound: "spicy"),
        Question(interrogative: "Sweet", transcriotion: "[swiːt]", answers: ["Сладкий", "Солёный", "Жирный", "Кислый"], correctAnswerIndex: 0, sound: "sweet"),
        Question(interrogative: "Tasty", transcriotion: "[ˈteɪstɪ]", answers: ["Очень вкусный", "Вкусный", "Еда", "Пробовать"], correctAnswerIndex: 1, sound: "tasty")
    ]
    //drink
    let drink = [
        Question(interrogative: "Coffe", transcriotion: "[ˈkɒfə]", answers: ["Кофе", "Вода", "Какао", "Чай"], correctAnswerIndex: 0, sound: "coffe"),
        Question(interrogative: "Cocoa", transcriotion: "[ˈkəʊkəʊ]", answers: ["Кофе", "Какао", "Чай", "Сок"], correctAnswerIndex: 1, sound: "cocoa"),
        Question(interrogative: "Juice", transcriotion: "[ʤuːs]", answers: ["Минеральная вода", "Лимонад", "Сок", "Газировка"], correctAnswerIndex: 2, sound: "juice"),
        Question(interrogative: "Lemonade", transcriotion: "[leməˈneɪd]", answers: ["Газировка", "Вода", "Сок", "Лимонад"], correctAnswerIndex: 3, sound: "lemonade"),
        Question(interrogative: "Mineral water", transcriotion: "[ˈmɪnərəl ˈwɔːtə]", answers: ["Минеральная вода", "Чай", "Лимонад", "Вода"], correctAnswerIndex: 0, sound: "mineralWater"),
        Question(interrogative: "Smoothie", transcriotion: "[ˈsmuːðɪ]", answers: ["Газировка", "Смузи", "Чай", "Коктейль"], correctAnswerIndex: 1, sound: "smoothie"),
        Question(interrogative: "Soda", transcriotion: "[ˈsəʊdə]", answers: ["Бренди", "Сок", "Газировка", "Лимонад"], correctAnswerIndex: 2, sound: "soda"),
        Question(interrogative: "Tea", transcriotion: "[tiː]", answers: ["Вино", "Кофе", "Какао", "Чай"], correctAnswerIndex: 3, sound: "tea"),
        Question(interrogative: "Water", transcriotion: "[ˈwɔːtə]", answers: ["Вода", "Вино", "Шампанское", "Кофе"], correctAnswerIndex: 0, sound: "water"),
        Question(interrogative: "Alcohol", transcriotion: "[ˈælkəhɒl]", answers: ["Пиво", "Алкоголь", "Шампанское", "Бренди"], correctAnswerIndex: 1, sound: "alcohol"),
        Question(interrogative: "Beer", transcriotion: "[bɪə]", answers: ["Коньяк", "Виски", "Пиво", "Коктейль"], correctAnswerIndex: 2, sound: "beer"),
        Question(interrogative: "Brandy", transcriotion: "[ˈbrændɪ]", answers: ["Коктейль", "Ром", "Вино", "Бренди"], correctAnswerIndex: 3, sound: "brandy"),
        Question(interrogative: "Champagne", transcriotion: "[ʃæmˈpeɪn]", answers: ["Шампанское", "Виски", "Коньяк", "Пиво"], correctAnswerIndex: 0, sound: "champagne"),
        Question(interrogative: "Cocktail", transcriotion: "[ˈkɒkteɪl]", answers: ["Вино", "Коктейль", "Бренди", "Ром"], correctAnswerIndex: 1, sound: "cocktail"),
        Question(interrogative: "Cognac", transcriotion: "[ˈkɒnjæk]", answers: ["Пиво", "Шампанское", "Коньяк", "Виски"], correctAnswerIndex: 2, sound: "cognac"),
        Question(interrogative: "Rum", transcriotion: "[rʌm]", answers: ["Бренди", "Коньяк", "Коктейль", "Ром"], correctAnswerIndex: 3, sound: "rum"),
        Question(interrogative: "Wine", transcriotion: "[waɪn]", answers: ["Вино", "Виски", "Вода", "Пиво"], correctAnswerIndex: 0, sound: "wine"),
        Question(interrogative: "Whiskey", transcriotion: "[ˈwɪskɪ]", answers: ["Бренди", "Виски", "Ром", "Вино"], correctAnswerIndex: 1, sound: "whiskey")
    ]
    
    //drinkReverse
    let drinkReverse = [
        Question(interrogative: "Coffe", transcriotion: "", answers: ["Кофе", "Вода", "Какао", "Чай"], correctAnswerIndex: 0, sound: "coffe"),
        Question(interrogative: "Cocoa", transcriotion: "", answers: ["Кофе", "Какао", "Чай", "Сок"], correctAnswerIndex: 1, sound: "cocoa"),
        Question(interrogative: "Juice", transcriotion: "", answers: ["Минеральная вода", "Лимонад", "Сок", "Газировка"], correctAnswerIndex: 2, sound: "juice"),
        Question(interrogative: "Lemonade", transcriotion: "", answers: ["Газировка", "Вода", "Сок", "Лимонад"], correctAnswerIndex: 3, sound: "lemonade"),
        Question(interrogative: "Mineral water", transcriotion: "", answers: ["Минеральная вода", "Чай", "Лимонад", "Вода"], correctAnswerIndex: 0, sound: "mineralWater"),
        Question(interrogative: "Smoothie", transcriotion: "", answers: ["Газировка", "Смузи", "Чай", "Коктейль"], correctAnswerIndex: 1, sound: "smoothie"),
        Question(interrogative: "Soda", transcriotion: "", answers: ["Бренди", "Сок", "Газировка", "Лимонад"], correctAnswerIndex: 2, sound: "soda"),
        Question(interrogative: "Tea", transcriotion: "", answers: ["Вино", "Кофе", "Какао", "Чай"], correctAnswerIndex: 3, sound: "tea"),
        Question(interrogative: "Water", transcriotion: "", answers: ["Вода", "Вино", "Шампанское", "Кофе"], correctAnswerIndex: 0, sound: "water"),
        Question(interrogative: "Alcohol", transcriotion: "", answers: ["Пиво", "Алкоголь", "Шампанское", "Бренди"], correctAnswerIndex: 1, sound: "alcohol"),
        Question(interrogative: "Beer", transcriotion: "", answers: ["Коньяк", "Виски", "Пиво", "Коктейль"], correctAnswerIndex: 2, sound: "beer"),
        Question(interrogative: "Brandy", transcriotion: "", answers: ["Коктейль", "Ром", "Вино", "Бренди"], correctAnswerIndex: 3, sound: "brandy"),
        Question(interrogative: "Champagne", transcriotion: "", answers: ["Шампанское", "Виски", "Коньяк", "Пиво"], correctAnswerIndex: 0, sound: "champagne"),
        Question(interrogative: "Cocktail", transcriotion: "", answers: ["Вино", "Коктейль", "Бренди", "Ром"], correctAnswerIndex: 1, sound: "cocktail"),
        Question(interrogative: "Cognac", transcriotion: "", answers: ["Пиво", "Шампанское", "Коньяк", "Виски"], correctAnswerIndex: 2, sound: "cognac"),
        Question(interrogative: "Rum", transcriotion: "", answers: ["Бренди", "Коньяк", "Коктейль", "Ром"], correctAnswerIndex: 3, sound: "rom"),
        Question(interrogative: "Wine", transcriotion: "", answers: ["Вино", "Виски", "Вода", "Пиво"], correctAnswerIndex: 0, sound: "wine"),
        Question(interrogative: "Whiskey", transcriotion: "", answers: ["Бренди", "Виски", "Ром", "Вино"], correctAnswerIndex: 1, sound: "whiskey"),
        Question(interrogative: "Кофе", transcriotion: "", answers: ["Coffe", "Cocoa", "Tea", "Cognac"], correctAnswerIndex: 0, sound: "coffe"),
        Question(interrogative: "Какао", transcriotion: "", answers: ["Cognac", "Cocoa", "Cocktail", "Coffe"], correctAnswerIndex: 1, sound: "cocoa"),
        Question(interrogative: "Сок", transcriotion: "", answers: ["Lemonade", "Soda", "Juice", "Water"], correctAnswerIndex: 2, sound: "juice"),
        Question(interrogative: "Лимонад", transcriotion: "", answers: ["Water", "Soda", "Juice", "Lemonade"], correctAnswerIndex: 3, sound: "lemonade"),
        Question(interrogative: "Минеральная вода", transcriotion: "", answers: ["Mineral water", "Water", "Lemonade", "Soda"], correctAnswerIndex: 0, sound: "mineralWater"),
        Question(interrogative: "Смузи", transcriotion: "", answers: ["Champange", "Smoothie", "Soda", "Juice"], correctAnswerIndex: 1, sound: "smoothie"),
        Question(interrogative: "Газировка", transcriotion: "", answers: ["Lemonade", "Juice", "Soda", "Water"], correctAnswerIndex: 2, sound: "soda"),
        Question(interrogative: "Чай", transcriotion: "", answers: ["Cognac", "Brandy", "Coffe", "Tea"], correctAnswerIndex: 3, sound: "tea"),
        Question(interrogative: "Вода", transcriotion: "", answers: ["Water", "Beer", "Mineral water", "Alcohol"], correctAnswerIndex: 0, sound: "water"),
        Question(interrogative: "Алкоголь", transcriotion: "", answers: ["Beer", "Alcohol", "Cocktail", "Brandy"], correctAnswerIndex: 1, sound: "alcohol"),
        Question(interrogative: "Пиво", transcriotion: "", answers: ["Whiskey", "Brandy", "Beer", "Wine"], correctAnswerIndex: 2, sound: "beer"),
        Question(interrogative: "Бренди", transcriotion: "", answers: ["Whiskey", "Rum", "Beer", "Brandy"], correctAnswerIndex: 3, sound: "brandy"),
        Question(interrogative: "Шампанское", transcriotion: "", answers: ["Champange", "Wine", "Cognac", "Cocktail"], correctAnswerIndex: 0, sound: "champagne"),
        Question(interrogative: "Коктейль", transcriotion: "", answers: ["Cognac", "Cocktail", "Rum", "Champange"], correctAnswerIndex: 1, sound: "cocktail"),
        Question(interrogative: "Коньяк", transcriotion: "", answers: ["Wine", "Cocktail", "Cognac", "Champange"], correctAnswerIndex: 2, sound: "cognac"),
        Question(interrogative: "Ром", transcriotion: "", answers: ["Brandy", "Whiskey", "Beer", "Rum"], correctAnswerIndex: 3, sound: "rom"),
        Question(interrogative: "Вино", transcriotion: "", answers: ["Wine", "Cocktail", "Cognac", "Whiskey"], correctAnswerIndex: 0, sound: "wine"),
        Question(interrogative: "Виски", transcriotion: "", answers: ["Beer", "Whiskey", "Cocktail", "Wine"], correctAnswerIndex: 1, sound: "whiskey")
    ]
    
    //milk
    let milk = [
        Question(interrogative: "Butter", transcriotion: "[ˈbʌtə]", answers: ["Масло", "Сухое молоко", "Творог", "Лактоза"], correctAnswerIndex: 0, sound: "butter"),
        Question(interrogative: "Cheese", transcriotion: "[ʧiːz]", answers: ["Мороженное", "Сыр", "Молоко", "Сливки"], correctAnswerIndex: 1, sound: "cheese"),
        Question(interrogative: "Condensed milk", transcriotion: "[kənˈdenst mɪlk]", answers: ["Кефир", "Сметана", "Сгущеное молоко", "Сыворотка"], correctAnswerIndex: 2, sound: "condensedMilk"),
        Question(interrogative: "Cottage cheese", transcriotion: "[ˈkɒtɪʤ ʧiːz]", answers: ["Сухое молоко", "Масло", "Лактоза", "Творог"], correctAnswerIndex: 3, sound: "cottageCheese"),
        Question(interrogative: "Cream", transcriotion: "[kriːm]", answers: ["Сливки", "Молоко", "Сыр", "Мороженное"], correctAnswerIndex: 0, sound: "cream"),
        Question(interrogative: "Dried milk", transcriotion: "[draɪd mɪlk]", answers: ["Лактоза", "Масло", "Сухое молоко", "Творог"], correctAnswerIndex: 2, sound: "driedMilk"),
        Question(interrogative: "Ice cream", transcriotion: "[aɪsˈkriːm]", answers: ["Молоко", "Сыр", "Сливки", "Мороженное"], correctAnswerIndex: 3, sound: "iceCream"),
        Question(interrogative: "Kefir", transcriotion: "[ˈkefə]", answers: ["Кефир", "Сметана", "Сгущеное молоко", "Сыворотка"], correctAnswerIndex: 0, sound: "kefir"),
        Question(interrogative: "Lactose", transcriotion: "[ˈlæktəʊs]", answers: ["Творог", "Лактоза", "Сухое молоко", "Масло"], correctAnswerIndex: 1, sound: "lactose"),
        Question(interrogative: "Milk", transcriotion: "[mɪlk]", answers: ["Сыр", "Сливки", "Молоко", "Мороженное"], correctAnswerIndex: 2, sound: "milk"),
        Question(interrogative: "Milk shake", transcriotion: "[mɪlk ʃeɪk]", answers: ["Сыворотка", "Сгущеное молоко", "Йогурт", "Молочный коктейль"], correctAnswerIndex: 3, sound: "milkShake"),
        Question(interrogative: "Sour cream", transcriotion: "[ˈsaʊə kriːm]", answers: ["Сухое молоко", "Сметана", "Творог", "Масло"], correctAnswerIndex: 1, sound: "sourCream"),
        Question(interrogative: "Whey", transcriotion: "[weɪ]", answers: ["Мороженное", "Сыр", "Сыворотка", "Сливки"], correctAnswerIndex: 2, sound: "whey"),
        Question(interrogative: "Yogurt", transcriotion: "[ˈjɒgət]", answers: ["Лактоза", "Сгущеное молоко", "Сметана", "Йогурт"], correctAnswerIndex: 3, sound: "yogurt")
    ]
    
    //milkReverse
    let milkReverse = [
        Question(interrogative: "Butter", transcriotion: "", answers: ["Масло", "Сухое молоко", "Творог", "Лактоза"], correctAnswerIndex: 0, sound: "butter"),
        Question(interrogative: "Cheese", transcriotion: "", answers: ["Мороженное", "Сыр", "Молоко", "Сливки"], correctAnswerIndex: 1, sound: "cheese"),
        Question(interrogative: "Condensed milk", transcriotion: "", answers: ["Кефир", "Сметана", "Сгущеное молоко", "Сыворотка"], correctAnswerIndex: 2, sound: "condensedMilk"),
        Question(interrogative: "Cottage cheese", transcriotion: "", answers: ["Сухое молоко", "Масло", "Лактоза", "Творог"], correctAnswerIndex: 3, sound: "cottageCheese"),
        Question(interrogative: "Cream", transcriotion: "", answers: ["Сливки", "Молоко", "Сыр", "Мороженное"], correctAnswerIndex: 0, sound: "cream"),
        Question(interrogative: "Dried milk", transcriotion: "", answers: ["Лактоза", "Масло", "Сухое молоко", "Творог"], correctAnswerIndex: 2, sound: "driedMilk"),
        Question(interrogative: "Ice cream", transcriotion: "", answers: ["Молоко", "Сыр", "Сливки", "Мороженное"], correctAnswerIndex: 3, sound: "iceCream"),
        Question(interrogative: "Kefir", transcriotion: "", answers: ["Кефир", "Сметана", "Сгущеное молоко", "Сыворотка"], correctAnswerIndex: 0, sound: "kefir"),
        Question(interrogative: "Lactose", transcriotion: "", answers: ["Творог", "Лактоза", "Сухое молоко", "Масло"], correctAnswerIndex: 1, sound: "lactose"),
        Question(interrogative: "Milk", transcriotion: "", answers: ["Сыр", "Сливки", "Молоко", "Мороженное"], correctAnswerIndex: 2, sound: "milk"),
        Question(interrogative: "Milk shake", transcriotion: "", answers: ["Сыворотка", "Сгущеное молоко", "Йогурт", "Молочный коктейль"], correctAnswerIndex: 3, sound: "milkShake"),
        Question(interrogative: "Sour cream", transcriotion: "", answers: ["Сухое молоко", "Сметана", "Творог", "Масло"], correctAnswerIndex: 1, sound: "sourCream"),
        Question(interrogative: "Whey", transcriotion: "", answers: ["Мороженное", "Сыр", "Сыворотка", "Сливки"], correctAnswerIndex: 2, sound: "whey"),
        Question(interrogative: "Yogurt", transcriotion: "", answers: ["Лактоза", "Сгущеное молоко", "Сметана", "Йогурт"], correctAnswerIndex: 3, sound: "yogurt"),
        Question(interrogative: "Масло", transcriotion: "", answers: ["Butter", "Sour cream", "Dried milk", "Lactose"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Сыр", transcriotion: "", answers: ["Milk", "Cheese", "Ice cream", "Whey"], correctAnswerIndex: 1, sound: ""),
        Question(interrogative: "Сгущеное молоко", transcriotion: "", answers: ["Kefir", "Milk shake", "Condensed milk", "Yogurt"], correctAnswerIndex: 2, sound: ""),
        Question(interrogative: "Творог", transcriotion: "", answers: ["Dried milk", "Butter", "Sour cream", "Cottage cheese"], correctAnswerIndex: 3, sound: ""),
        Question(interrogative: "Сливки", transcriotion: "", answers: ["Cream", "Whey", "Ice cream", "Cheese"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Сухое молоко", transcriotion: "", answers: ["Butter", "Lactose", "Dried milk", "Sour cream"], correctAnswerIndex: 2, sound: ""),
        Question(interrogative: "Мороженое", transcriotion: "", answers: ["Milk", "Cheese", "Whey", "Ice cream"], correctAnswerIndex: 3, sound: ""),
        Question(interrogative: "Кефир", transcriotion: "", answers: ["Kefir", "Condensed milk", "Milk shake", "Yogurt"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Лактоза", transcriotion: "", answers: ["Sour cream", "Lactose", "Dried milk", "Butter"], correctAnswerIndex: 1, sound: ""),
        Question(interrogative: "Молоко", transcriotion: "", answers: ["Cheese", "Whey", "Milk", "Ice cream"], correctAnswerIndex: 2, sound: ""),
        Question(interrogative: "Молочный коктейль", transcriotion: "", answers: ["Kefir", "Yogurt", "Condensed milk", "Milk shake"], correctAnswerIndex: 3, sound: ""),
        Question(interrogative: "Сметана", transcriotion: "", answers: ["Sour cream", "Lactose", "Butter", "Dried milk"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Сыворотка", transcriotion: "", answers: ["Ice cream", "Whey", "Milk", "Cheese"], correctAnswerIndex: 1, sound: ""),
        Question(interrogative: "Йогурт", transcriotion: "", answers: ["Condensed milk", "Milk shake", "Yogurt", "Kefir"], correctAnswerIndex: 2, sound: "")
    ]
    
    //vegetable
    let vegetable = [
        Question(interrogative: "Asparagus", transcriotion: "[əsˈpærəgəs]", answers: ["Спаржа", "Бобы", "Шпинат", "Петрушка"], correctAnswerIndex: 0, sound: "asparagus"),
        Question(interrogative: "Avocado", transcriotion: "[ævəˈkɑːdəʊ]", answers: ["Картофель", "Авокадо", "Брокколи", "Помидор"], correctAnswerIndex: 1, sound: "avocado"),
        Question(interrogative: "Beet", transcriotion: "[biːt]", answers: ["Гриб", "Репа", "Свёкла", "Морковь"], correctAnswerIndex: 2, sound: "beet"),
        Question(interrogative: "Broccoli", transcriotion: "[ˈbrɒkəlɪ]", answers: ["Помидор", "Брокколи", "Авокадо", "Картофель"], correctAnswerIndex: 1, sound: "broccoli"),
        Question(interrogative: "Carrot", transcriotion: "[ˈkærət]", answers: ["Репа", "Свёкла", "Морковь", "Тыква"], correctAnswerIndex: 2, sound: "carrot"),
        Question(interrogative: "Corn", transcriotion: "[kɔːn]", answers: ["Горох", "Редис", "Стручковая фасоль", "Кукуруза"], correctAnswerIndex: 3, sound: "corn"),
        Question(interrogative: "Cabbage", transcriotion: "[ˈkæbɪʤ]", answers: ["Капуста", "Шпинат", "Петрушка", "Спаржа"], correctAnswerIndex: 0, sound: "cabbage"),
        Question(interrogative: "Cucumber", transcriotion: "[ˈkjuːkʌmbə]", answers: ["Авокадо", "Огурец", "Помидор", "Брокколи"], correctAnswerIndex: 1, sound: "cucumber"),
        Question(interrogative: "Eggplant", transcriotion: "[ˈegplɑːnt]", answers: ["Свёкла", "Морковь", "Баклажан", "Репа"], correctAnswerIndex: 2, sound: "eggplant"),
        Question(interrogative: "Garlic", transcriotion: "[ˈgɑːlɪk]", answers: ["Редис", "Стручковая фасоль", "Кукуруза", "Чеснок"], correctAnswerIndex: 3, sound: "garlic"),
        Question(interrogative: "Mushroom", transcriotion: "[ˈmʌʃrum]", answers: ["Гриб", "Спаржа", "Шпинат", "Бобы"], correctAnswerIndex: 0, sound: "mushroom"),
        Question(interrogative: "Onion", transcriotion: "[ˈʌnjən]", answers: ["Брокколи", "Лук", "Авокадо", "Помидор"], correctAnswerIndex: 1, sound: "onion"),
        Question(interrogative: "Pea", transcriotion: "[piː]", answers: ["Стручковая фасоль", "Редис", "Кукуруза", "Горох"], correctAnswerIndex: 3, sound: "pea"),
        Question(interrogative: "Pepper", transcriotion: "[ˈpepə]", answers: ["Перец", "Гриб", "Спаржа", "Шпинат"], correctAnswerIndex: 0, sound: "pepper"),
        Question(interrogative: "Potato", transcriotion: "[pəˈteɪtəʊ]", answers: ["Помидор", "Картофель", "Брокколи", "Авокадо"], correctAnswerIndex: 1, sound: "potato"),
        Question(interrogative: "Pumpkin", transcriotion: "[ˈpʌmpkɪn]", answers: ["Репа", "Свёкла", "Тыква", "Морковь"], correctAnswerIndex: 2, sound: "pumpkin"),
        Question(interrogative: "Radish", transcriotion: "[ˈrædɪʃ]", answers: ["Кукуруза", "Стручковая фасоль", "Горох", "Редис"], correctAnswerIndex: 3, sound: "radish"),
        Question(interrogative: "Tomato", transcriotion: "[təˈmɑːtəʊ]", answers: ["Картофель", "Помидор", "Авокадо", "Брокколи"], correctAnswerIndex: 1, sound: "tomato"),
        Question(interrogative: "Turnip", transcriotion: "[ˈtɜːnɪp]", answers: ["Свёкла", "Морковь", "Репа", "Тыква"], correctAnswerIndex: 2, sound: "turnip")
    ]
    
    //Fruit
    let fruit = [
        Question(interrogative: "Apple", transcriotion: "[æpl]", answers: ["Яблоко", "Малина", "Банан", "Вишня"], correctAnswerIndex: 0, sound: "apple"),
        Question(interrogative: "Apricot", transcriotion: "[ˈeɪprɪkɒt]", answers: ["Ананас", "Абрикос", "Груша", "Манго"], correctAnswerIndex: 1, sound: "apricot"),
        Question(interrogative: "Banana", transcriotion: "[bəˈnɑːnə]", answers: ["Яблоко", "Клубника", "Банан", "Персик"], correctAnswerIndex: 2, sound: "banana"),
        Question(interrogative: "Barberry", transcriotion: "[ˈbɑːbərɪ]", answers: ["Черника", "Ежевика", "Клюква", "Барбарис"], correctAnswerIndex: 3, sound: "barberry"),
        Question(interrogative: "Blackberry", transcriotion: "[ˈblækb(ə)rɪ]", answers: ["Ежевика", "Черника", "Земляника", "Клюква"], correctAnswerIndex: 0, sound: "blackberry"),
        Question(interrogative: "Black currant", transcriotion: "[blæk ˈkʌrənt]", answers: ["Красная смородина", "Черная смородина", "Яблоко", "Арбуз"], correctAnswerIndex: 1, sound: "blackCurrant"),
        Question(interrogative: "Blueberry", transcriotion: "[ˈbluːb(ə)rɪ]", answers: ["Абрикос", "Гранат", "Черника", "Папайя"], correctAnswerIndex: 2, sound: "blueberry"),
        Question(interrogative: "Cherry", transcriotion: "[ˈʧerɪ]", answers: ["Маракуйя", "Банан", "Малина", "Вишня"], correctAnswerIndex: 3, sound: "cherry"),
        Question(interrogative: "Coconut", transcriotion: "[ˈkəʊkənʌt]", answers: ["Кокос", "Апельсин", "Барбарис", "Ананас"], correctAnswerIndex: 0, sound: "coconut"),
        Question(interrogative: "Cranberry", transcriotion: "[ˈkrænbərɪ]", answers: ["Смородина", "Клюква", "Ежевика", "Клубника"], correctAnswerIndex: 1, sound: "cranberry"),
        Question(interrogative: "Currant", transcriotion: "[ˈkɜːrənt]", answers: ["Ежевика", "Клюква", "Смородина", "Черника"], correctAnswerIndex: 2, sound: "currant"),
        Question(interrogative: "Grapefruit", transcriotion: "[ˈgreɪpfruːt]", answers: ["Хурма", "Виноград", "Абрикос", "Грейпфрут"], correctAnswerIndex: 3, sound: "grapefruit"),
        Question(interrogative: "Grape", transcriotion: "[greɪp]", answers: ["Виноград", "Арбуз", "Грейпфрут", "Банан"], correctAnswerIndex: 0, sound: "grape"),
        Question(interrogative: "Kiwi", transcriotion: "[ˈkiːwiː]", answers: ["Барбарис", "Киви", "Папайя", "Гранат"], correctAnswerIndex: 1, sound: "kiwi"),
        Question(interrogative: "Lemon", transcriotion: "[ˈlemən]", answers: ["Малина", "Лайм", "Лемон", "Ежевика"], correctAnswerIndex: 2, sound: "lemon"),
        Question(interrogative: "Lime", transcriotion: "[laɪm]", answers: ["Лемон", "Ананас", "Яблоко", "Лайм"], correctAnswerIndex: 3, sound: "lime"),
        Question(interrogative: "Mango", transcriotion: "[ˈmæŋgəʊ]", answers: ["Манго", "Персик", "Клубника", "Абрикос"], correctAnswerIndex: 0, sound: "mango"),
        Question(interrogative: "Melon", transcriotion: "[ˈmelən]", answers: ["Банан", "Дыня", "Арбуз", "Мандарин"], correctAnswerIndex: 1, sound: "melon"),
        Question(interrogative: "Nectarine", transcriotion: "[ˈnektəriːn]", answers: ["Кокос", "Барбарис", "Нектарин", "Хурма"], correctAnswerIndex: 2, sound: "nectarine"),
        Question(interrogative: "Orange", transcriotion: "[ˈɒrɪnʤ]", answers: ["Слива", "Ежевика", "Арбуз", "Апельсин"], correctAnswerIndex: 3, sound: "orangeFruit"),
        Question(interrogative: "Papaya", transcriotion: "[pəˈpaɪə]", answers: ["Папайя", "Киви", "Гранат", "Яблоко"], correctAnswerIndex: 0, sound: "papaya"),
        Question(interrogative: "Passion fruit", transcriotion: "[pæʃn fruːt]", answers: ["Кокос", "Маракуйя", "Абрикос", "Малина"], correctAnswerIndex: 1, sound: "passionFruit"),
        Question(interrogative: "Pineapple", transcriotion: "[ˈpaɪnæpl]", answers: ["Лайм", "Банан", "Ананас", "Вишня"], correctAnswerIndex: 2, sound: "pineapple"),
        Question(interrogative: "Peach", transcriotion: "[piːʧ]", answers: ["Манго", "Клубника", "Барбарис", "Персик"], correctAnswerIndex: 3, sound: "peach"),
        Question(interrogative: "Pear", transcriotion: "[peə]", answers: ["Груша", "Мандарин", "Ежевика", "Дыня"], correctAnswerIndex: 0, sound: "pear"),
        Question(interrogative: "Persimmon", transcriotion: "[pərˈsɪmən]", answers: ["Яблоко", "Хурма", "Нектарин", "Грейпфрут"], correctAnswerIndex: 1, sound: "persimmon"),
        Question(interrogative: "Plum", transcriotion: "[plʌm]", answers: ["Абрикос", "Арбуз", "Слива", "Апельсин"], correctAnswerIndex: 2, sound: "plum"),
        Question(interrogative: "Pomegranate", transcriotion: "[ˈpɒmɪgrænɪt]", answers: ["Киви", "Папайя", "Банан", "Гранат"], correctAnswerIndex: 3, sound: "pomegranate"),
        Question(interrogative: "Raspberry", transcriotion: "[ˈrɑːzbərɪ]", answers: ["Малина", "Виноград", "Маракуйя", "Барбарис"], correctAnswerIndex: 0, sound: "raspberry"),
        Question(interrogative: "Red currant", transcriotion: "[ˈred kʌrənt]", answers: ["Ежевика", "Красная смородина", "Ананас", "Черная смородина"], correctAnswerIndex: 1, sound: "redCurrant"),
        Question(interrogative: "Strawberry", transcriotion: "[ˈstrɔːbərɪ]", answers: ["Персик", "Яблоко", "Клубника", "Персик"], correctAnswerIndex: 2, sound: "strawberry"),
        Question(interrogative: "Tangerine", transcriotion: "[tænʤəˈriːn]", answers: ["Дыня", "Абрикос", "Груша", "Мандарин"], correctAnswerIndex: 3, sound: "tangerine"),
        Question(interrogative: "Watermelon", transcriotion: "[ˈwɔːtəmelən]", answers: ["Арбуз", "Банан", "Нектарин", "Хурма"], correctAnswerIndex: 0, sound: "watermelon")
    ]
    
    //nut
    let nut = [
        Question(interrogative: "Almond", transcriotion: "[ˈɑːmənd]", answers: ["Миндаль", "Курага", "Пекан", "Грецкий орех"], correctAnswerIndex: 0, sound: "almond"),
        Question(interrogative: "Brazil nut", transcriotion: "[brəˈzɪl nʌt]", answers: ["Фисташки", "Бразильский орех", "Фундук", "Финик"], correctAnswerIndex: 1, sound: "brazilNut"),
        Question(interrogative: "Cashew", transcriotion: "[kæˈʃuː]", answers: ["Чернослив", "Макадамия", "Кешью", "Изюм"], correctAnswerIndex: 2, sound: "cashew"),
        Question(interrogative: "Date", transcriotion: "[deɪt]", answers: ["Изюм", "Чернослив", "Арахис", "Финик"], correctAnswerIndex: 3, sound: "date"),
        Question(interrogative: "Dried apricots", transcriotion: "[draɪd ˈeɪprɪkɒts]", answers: ["Курага", "Миндаль", "Пекан", "Грецкий орех"], correctAnswerIndex: 0, sound: "driedApricots"),
        Question(interrogative: "Hazelnut", transcriotion: "[ˈheɪzlnʌt]", answers: ["Арахис", "Фундук", "Бразильский орех", "Фисташки"], correctAnswerIndex: 1, sound: "hazelnut"),
        Question(interrogative: "Macadamia", transcriotion: "[mækɪˈdiːmɪə]", answers: ["Бразильский орех", "Чернослив", "Макадамия", "Кешью"], correctAnswerIndex: 2, sound: "macadamia"),
        Question(interrogative: "Peanut", transcriotion: "[ˈpiːnʌt]", answers: ["Кешью", "Изюм", "Финик", "Арахис"], correctAnswerIndex: 3, sound: "peanut"),
        Question(interrogative: "Pecan", transcriotion: "[pɪˈkæn]", answers: ["Пекан", "Грецкий орех", "Миндаль", "Курага"], correctAnswerIndex: 0, sound: "pecan"),
        Question(interrogative: "Pistachio", transcriotion: "[pɪsˈtɑːʃɪəʊ]", answers: ["Макадамия", "Фисташки", "Фундук", "Бразильский орех"], correctAnswerIndex: 1, sound: "pistachio"),
        Question(interrogative: "Prune", transcriotion: "[pruːn]", answers: ["Кешью", "Фундук", "Чернослив", "Макадамия"], correctAnswerIndex: 2, sound: "prune"),
        Question(interrogative: "Raisin", transcriotion: "[reɪzn]", answers: ["Арахис", "Финик", "Фисташки", "Изюм"], correctAnswerIndex: 3, sound: "raisin"),
        Question(interrogative: "Walnut", transcriotion: "[ˈwɔːlnʌt]", answers: ["Грецкий орех", "Пекан", "Курага", "Миндаль"], correctAnswerIndex: 0, sound: "walnut")
    ]
    
    //meat
    let meat = [
        Question(interrogative: "Bacon", transcriotion: "[ˈbeɪkən]", answers: ["Бекон", "Икра", "Баранина", "Кальмар"], correctAnswerIndex: 0, sound: "bacon"),
        Question(interrogative: "Beef", transcriotion: "[biːf]", answers: ["Тунец", "Говядина", "Рак", "Свинина"], correctAnswerIndex: 1, sound: "beef"),
        Question(interrogative: "Chicken", transcriotion: "[ˈʧɪkɪn]", answers: ["Осьминог", "Колбаса", "Курица", "Краб"], correctAnswerIndex: 2, sound: "chicken"),
        Question(interrogative: "Ham", transcriotion: "[hæm]", answers: ["Ветчина", "Креветка", "Индейка", "Лосось"], correctAnswerIndex: 0, sound: "ham"),
        Question(interrogative: "Mutton", transcriotion: "[mʌtn]", answers: ["Кальмар", "Баранина", "Бекон", "Икра"], correctAnswerIndex: 1, sound: "mutton"),
        Question(interrogative: "Pork", transcriotion: "[pɔːk]", answers: ["Говядина", "Рак", "Свинина", "Тунец"], correctAnswerIndex: 2, sound: "pork"),
        Question(interrogative: "Sausage", transcriotion: "[ˈsɒsɪʤ]", answers: ["Осьминог", "Курица", "Краб", "Колбаса"], correctAnswerIndex: 3, sound: "sausage"),
        Question(interrogative: "Steak", transcriotion: "[steɪk]", answers: ["Стейк", "Ветчина", "Утка", "Лосось"], correctAnswerIndex: 0, sound: "steak"),
        Question(interrogative: "Turkey", transcriotion: "[ˈtɜːkɪ]", answers: ["Утка", "Индейка", "Ветчина", "Креветка"], correctAnswerIndex: 1, sound: "turkey"),
        Question(interrogative: "Caviar", transcriotion: "[ˈkævɪɑː]", answers: ["Баранина", "Кальмар", "Икра", "Бекон"], correctAnswerIndex: 2, sound: "caviar"),
        Question(interrogative: "Cancer", transcriotion: "[ˈkænsə]", answers: ["Тунец", "Свинина", "Говядина", "Рак"], correctAnswerIndex: 3, sound: "cancer"),
        Question(interrogative: "Crab", transcriotion: "[kræb]", answers: ["Краб", "Осьминог", "Колбаса", "Курица"], correctAnswerIndex: 0, sound: "crab"),
        Question(interrogative: "Salmon", transcriotion: "[ˈsæmən]", answers: ["Утка", "Лосось", "Индейка", "Стейк"], correctAnswerIndex: 1, sound: "salmon"),
        Question(interrogative: "Shrimp", transcriotion: "[ʃrɪmp]", answers: ["Индейка", "Стейк", "Креветка", "Ветчина"], correctAnswerIndex: 2, sound: "shrimp"),
        Question(interrogative: "Squid", transcriotion: "[skwɪd]", answers: ["Икра", "Бекон", "Баранина", "Кальмар"], correctAnswerIndex: 3, sound: "squid"),
        Question(interrogative: "Tuna", transcriotion: "[ˈtjuːnə]", answers: ["Тунец", "Рак", "Свинина", "Говядина"], correctAnswerIndex: 0, sound: "tuna"),
        Question(interrogative: "Octopus", transcriotion: "[ˈɒktəpəs]", answers: ["Курица", "Осьминог", "Краб", "Колбаса"], correctAnswerIndex: 1, sound: "octopus")
    ]
    
    //products
    let products = [
        Question(interrogative: "Bread", transcriotion: "[bred]", answers: ["Хлеб", "Печенье", "Майонез", "Рис"], correctAnswerIndex: 0, sound: "bread"),
        Question(interrogative: "Buckwheat", transcriotion: "[ˈbʌkwiːt]", answers: ["Мюсли", "Гречка", "Тесто", "Соль"], correctAnswerIndex: 1, sound: "buckwheat"),
        Question(interrogative: "Canned", transcriotion: "[kænd]", answers: ["Горчица", "Яйцо", "Консервы", "Соус"], correctAnswerIndex: 2, sound: "canned"),
        Question(interrogative: "Cereal", transcriotion: "[ˈsɪərɪəl]", answers: ["Спагетти", "Мука", "Лапша", "Хлопья"], correctAnswerIndex: 3, sound: "cereal"),
        Question(interrogative: "Chips", transcriotion: "[ʧɪps]", answers: ["Рис", "Чипсы", "Кетчуп", "Масло"], correctAnswerIndex: 1, sound: "chips"),
        Question(interrogative: "Egg", transcriotion: "[eɡ]", answers: ["Яйцо", "Консервы", "Соус", "Горчица"], correctAnswerIndex: 0, sound: "egg"),
        Question(interrogative: "Honey", transcriotion: "[ˈhʌnɪ]", answers: ["Сахар", "Шоколад", "Мёд", "Овсянка"], correctAnswerIndex: 2, sound: "honey"),
        Question(interrogative: "Ketchup", transcriotion: "[ˈkeʧəp]", answers: ["Масло", "Майонез", "Чипсы", "Кетчуп"], correctAnswerIndex: 3, sound: "ketchup"),
        Question(interrogative: "Mayonnaise", transcriotion: "[meɪəˈneɪz]", answers: ["Майонез", "Мюсли", "Хлеб", "Рис"], correctAnswerIndex: 0, sound: "mayonnaise"),
        Question(interrogative: "Muesli", transcriotion: "[ˈmjuːzlɪ]", answers: ["Тесто", "Мюсли", "Гречка", "Соль"], correctAnswerIndex: 1, sound: "muesli"),
        Question(interrogative: "Mustard", transcriotion: "[ˈmʌstəd]", answers: ["Соус", "Яйцо", "Горчица", "Консервы"], correctAnswerIndex: 2, sound: "mustard"),
        Question(interrogative: "Noodles", transcriotion: "[nuːdl]", answers: ["Спагетти", "Хлопья", "Мука", "Лапша"], correctAnswerIndex: 3, sound: "noodles"),
        Question(interrogative: "Oatmeal", transcriotion: "[ˈəʊtmiːl]", answers: ["Овсянка", "Мёд", "Сливочное масло", "Сахар"], correctAnswerIndex: 0, sound: "oatmeal"),
        Question(interrogative: "Oil", transcriotion: "[ɔɪl]", answers: ["Мёд", "Масло", "Сливочное масло", "Чипсы"], correctAnswerIndex: 1, sound: "oil"),
        Question(interrogative: "Rice", transcriotion: "[raɪs]", answers: ["Соус", "Майонез", "Рис", "Хлеб"], correctAnswerIndex: 2, sound: "rice"),
        Question(interrogative: "Salt", transcriotion: "[sɔːlt]", answers: ["Мюсли", "Гречка", "Тесто", "Соль"], correctAnswerIndex: 3, sound: "salt"),
        Question(interrogative: "Sauce", transcriotion: "[sɔːs]", answers: ["Соус", "Консервы", "Яйцо", "Горчица"], correctAnswerIndex: 0, sound: "sauce"),
        Question(interrogative: "Spaghetti", transcriotion: "[spəˈgetɪ]", answers: ["Хлопья", "Спагетти", "Лапша", "Мука"], correctAnswerIndex: 1, sound: "spaghetti"),
        Question(interrogative: "Sugar", transcriotion: "[ˈʃʊgə]", answers: ["Мёд", "Овсянка", "Сахар", "Шоколад"], correctAnswerIndex: 2, sound: "sugar")
    ]
    
    //productsReverse
    let productsReverse = [
        Question(interrogative: "Bread", transcriotion: "[bred]", answers: ["Хлеб", "Печенье", "Майонез", "Рис"], correctAnswerIndex: 0, sound: "bread"),
        Question(interrogative: "Buckwheat", transcriotion: "[ˈbʌkwiːt]", answers: ["Мюсли", "Гречка", "Тесто", "Соль"], correctAnswerIndex: 1, sound: "buckwheat"),
        Question(interrogative: "Canned", transcriotion: "[kænd]", answers: ["Горчица", "Яйцо", "Консервы", "Соус"], correctAnswerIndex: 2, sound: "canned"),
        Question(interrogative: "Cereal", transcriotion: "[ˈsɪərɪəl]", answers: ["Спагетти", "Мука", "Лапша", "Хлопья"], correctAnswerIndex: 3, sound: "cereal"),
        Question(interrogative: "Chips", transcriotion: "[ʧɪps]", answers: ["Рис", "Чипсы", "Кетчуп", "Масло"], correctAnswerIndex: 1, sound: "chips"),
        Question(interrogative: "Egg", transcriotion: "[eɡ]", answers: ["Яйцо", "Консервы", "Соус", "Горчица"], correctAnswerIndex: 0, sound: "egg"),
        Question(interrogative: "Honey", transcriotion: "[ˈhʌnɪ]", answers: ["Сахар", "Шоколад", "Мёд", "Овсянка"], correctAnswerIndex: 2, sound: "honey"),
        Question(interrogative: "Ketchup", transcriotion: "[ˈkeʧəp]", answers: ["Масло", "Майонез", "Чипсы", "Кетчуп"], correctAnswerIndex: 3, sound: "ketchup"),
        Question(interrogative: "Mayonnaise", transcriotion: "[meɪəˈneɪz]", answers: ["Майонез", "Мюсли", "Хлеб", "Рис"], correctAnswerIndex: 0, sound: "mayonnaise"),
        Question(interrogative: "Muesli", transcriotion: "[ˈmjuːzlɪ]", answers: ["Тесто", "Мюсли", "Гречка", "Соль"], correctAnswerIndex: 1, sound: "Muesli"),
        Question(interrogative: "Mustard", transcriotion: "[ˈmʌstəd]", answers: ["Соус", "Яйцо", "Горчица", "Консервы"], correctAnswerIndex: 2, sound: "Mustard"),
        Question(interrogative: "Noodles", transcriotion: "[nuːdl]", answers: ["Спагетти", "Хлопья", "Мука", "Лапша"], correctAnswerIndex: 3, sound: "noodles"),
        Question(interrogative: "Oatmeal", transcriotion: "[ˈəʊtmiːl]", answers: ["Овсянка", "Мёд", "Консервы", "Сахар"], correctAnswerIndex: 0, sound: "oatmeal"),
        Question(interrogative: "Oil", transcriotion: "[ɔɪl]", answers: ["Мёд", "Масло", "Кетчуп", "Чипсы"], correctAnswerIndex: 1, sound: "oil"),
        Question(interrogative: "Rice", transcriotion: "[raɪs]", answers: ["Соус", "Майонез", "Рис", "Хлеб"], correctAnswerIndex: 2, sound: "rice"),
        Question(interrogative: "Salt", transcriotion: "[sɔːlt]", answers: ["Мюсли", "Гречка", "Тесто", "Соль"], correctAnswerIndex: 3, sound: "salt"),
        Question(interrogative: "Sauce", transcriotion: "[sɔːs]", answers: ["Соус", "Консервы", "Яйцо", "Горчица"], correctAnswerIndex: 0, sound: "sauce"),
        Question(interrogative: "Spaghetti", transcriotion: "[spəˈgetɪ]", answers: ["Хлопья", "Спагетти", "Лапша", "Мука"], correctAnswerIndex: 1, sound: "spaghetti"),
        Question(interrogative: "Sugar", transcriotion: "[ˈʃʊgə]", answers: ["Мёд", "Овсянка", "Сахар", "Шоколад"], correctAnswerIndex: 2, sound: "sugar"),
        Question(interrogative: "Хлеб", transcriotion: "", answers: ["Oil", "Butter", "Honey", "Bread"], correctAnswerIndex: 3, sound: ""),
        Question(interrogative: "Гречка", transcriotion: "", answers: ["Buckwheat", "Mayonnaise", "Egg", "Salt"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Консервы", transcriotion: "", answers: ["Sauce", "Canned", "Muesli", "Cereal"], correctAnswerIndex: 1, sound: ""),
        Question(interrogative: "Хлопья", transcriotion: "", answers: ["Mustard", "Spaghetti", "Cereal", "Rice"], correctAnswerIndex: 2, sound: ""),
        Question(interrogative: "Чипсы", transcriotion: "", answers: ["Canned", "Noodles", "Rice", "Chips"], correctAnswerIndex: 3, sound: ""),
        Question(interrogative: "Яйцо", transcriotion: "", answers: ["Egg", "Salt", "Oatmeal", "Oil"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Мёд", transcriotion: "", answers: ["Sugar", "Honey", "Oil", "Bread"], correctAnswerIndex: 1, sound: ""),
        Question(interrogative: "Кетчуп", transcriotion: "", answers: ["Rice", "Mayonnaise", "Ketchup", "Butter"], correctAnswerIndex: 2, sound: ""),
        Question(interrogative: "Майонез", transcriotion: "", answers: ["Salt", "Buckwheat", "Ketchup", "Mayonnaise"], correctAnswerIndex: 3, sound: ""),
        Question(interrogative: "Мюсли", transcriotion: "", answers: ["Muesli", "Sauce", "Canned", "Cereal"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Горчица", transcriotion: "", answers: ["Mayonnaise", "Mustard", "Ketchup", "Spaghetti"], correctAnswerIndex: 1, sound: ""),
        Question(interrogative: "Лапша", transcriotion: "", answers: ["Sugar", "Chips", "Noodles", "Spaghetti"], correctAnswerIndex: 2, sound: ""),
        Question(interrogative: "Овсянка", transcriotion: "", answers: ["Muesli", "Egg", "Sugar", "Oatmeal"], correctAnswerIndex: 3, sound: ""),
        Question(interrogative: "", transcriotion: "", answers: ["Oil", "Bread", "Butter", "Honey"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Рис", transcriotion: "", answers: ["Chips", "Rice", "Butter", "Ketchup"], correctAnswerIndex: 1, sound: ""),
        Question(interrogative: "Соль", transcriotion: "", answers: ["Mayonnaise", "Sauce", "Salt", "Buckwheat"], correctAnswerIndex: 2, sound: ""),
        Question(interrogative: "Соус", transcriotion: "", answers: ["Mustard", "Canned", "Muesli", "Sauce"], correctAnswerIndex: 3, sound: ""),
        Question(interrogative: "Спагетти", transcriotion: "", answers: ["Spaghetti", "Noodles", "Mustard", "Oatmeal"], correctAnswerIndex: 0, sound: ""),
        Question(interrogative: "Сахар", transcriotion: "", answers: ["Chips", "Sugar", "Honey", "Noodles"], correctAnswerIndex: 1, sound: "")
    ]
    
    //sweets
    let sweets = [
        Question(interrogative: "Bun", transcriotion: "[bʌn]", answers: ["Булочка", "Варенье", "Шоколад", "Ваниль"], correctAnswerIndex: 0, sound: "bun"),
        Question(interrogative: "Cake", transcriotion: "[keɪk]", answers: ["Конфета", "Торт", "Желе", "Печенье"], correctAnswerIndex: 1, sound: "cake"),
        Question(interrogative: "Candy", transcriotion: "[ˈkændɪ]", answers: ["Корица", "Леденец", "Конфета", "Карамель"], correctAnswerIndex: 2, sound: "candy"),
        Question(interrogative: "Candy bar", transcriotion: "[ˈkændɪ bɑː]", answers: ["Зефир", "Кекс", "Корица", "Шоколадный батончик"], correctAnswerIndex: 3, sound: "candyBar"),
        Question(interrogative: "Caramel", transcriotion: "[ˈkærəməl]", answers: ["Карамель", "Маффин", "Пончик", "Печенье"], correctAnswerIndex: 0, sound: "caramel"),
        Question(interrogative: "Chocolate", transcriotion: "[ˈʧɒklɪt]", answers: ["Ваниль", "Шоколад", "Булочка", "Варенье"], correctAnswerIndex: 1, sound: "chocolate"),
        Question(interrogative: "Cookie", transcriotion: "[ˈkʊkɪ]", answers: ["Торт", "Кекс", "Печенье", "Желе"], correctAnswerIndex: 2, sound: "cookie"),
        Question(interrogative: "Cinnamon", transcriotion: "[ˈsɪnəmən]", answers: ["Пончик", "Конфета", "Леденец", "Корица"], correctAnswerIndex: 3, sound: "cinnamon"),
        Question(interrogative: "Cupcake", transcriotion: "[ˈkʌpkeɪk]", answers: ["Кекс", "Зефир", "Шоколадный батончик", "Желе"], correctAnswerIndex: 0, sound: "cupcake"),
        Question(interrogative: "Donut", transcriotion: "[ˈdəʊnʌt]", answers: ["Леденец", "Пончик", "Карамель", "Маффин"], correctAnswerIndex: 1, sound: "donut"),
        Question(interrogative: "Jam", transcriotion: "[ʤæm]", answers: ["Шоколад", "Ваниль", "Варенье", "Булочка"], correctAnswerIndex: 2, sound: "jam"),
        Question(interrogative: "Jelly", transcriotion: "[ˈʤelɪ]", answers: ["Шоколадный батончик", "Печенье", "Торт", "Желе"], correctAnswerIndex: 3, sound: "jelly"),
        Question(interrogative: "Lollipop", transcriotion: "[ˈlɒlɪpɒp]", answers: ["Леденец", "Зефир", "Корица", "Конфета"], correctAnswerIndex: 0, sound: "lollipop"),
        Question(interrogative: "Marshmallow", transcriotion: "[mɑːʃˈmæləʊ]", answers: ["Шоколадный батончик", "Зефир", "Маффин", "Кекс"], correctAnswerIndex: 1, sound: "marshmallow"),
        Question(interrogative: "Muffin", transcriotion: "[ˈmʌfɪn]", answers: ["Пончик", "Торт", "Маффин", "Карамель"], correctAnswerIndex: 2, sound: "muffin"),
        Question(interrogative: "Vanilla", transcriotion: "[vəˈnɪlə]", answers: ["Варенье", "Булочка", "Шоколад", "Ваниль"], correctAnswerIndex: 3, sound: "vanilla")
    ]
    
    //cookedFood
    let cookedFood = [
        Question(interrogative: "Burger", transcriotion: "[ˈbɜːgə]", answers: ["Бургер", "Картошка фри", "Гамбургер", "Наггетсы"], correctAnswerIndex: 0, sound: "burger"),
        Question(interrogative: "Nuggets", transcriotion: "[ˈnʌgɪts]", answers: ["Лазанья", "Наггетсы", "Суши", "Хот-дог"], correctAnswerIndex: 1, sound: "nuggets"),
        Question(interrogative: "Fried eggs", transcriotion: "[fraɪd eg]", answers: ["Каша", "Омлет", "Яичница", "Хот-дог"], correctAnswerIndex: 2, sound: "friedEggs"),
        Question(interrogative: "French fries", transcriotion: "[frenʧ fraɪz]", answers: ["Лазанья", "Яичница", "Омлет", "Картошка фри"], correctAnswerIndex: 3, sound: "frenchFries"),
        Question(interrogative: "Hot dog", transcriotion: "[ˈhɒtdɒɡ]", answers: ["Хот-дог", "Лазанья", "Сэндвич", "Бургер"], correctAnswerIndex: 0, sound: "hotDog"),
        Question(interrogative: "Hamburger", transcriotion: "[ˈhæmbɜːgə]", answers: ["Картошка фри", "Гамбургер", "Яичница", "Бургер"], correctAnswerIndex: 1, sound: "hamburger"),
        Question(interrogative: "Porridge", transcriotion: "[ˈpɒrɪʤ]", answers: ["Пирог", "Омлет", "Каша", "Паста"], correctAnswerIndex: 2, sound: "porridge"),
        Question(interrogative: "Lasagne", transcriotion: "[ləˈzænjə]", answers: ["Гамбургер", "Наггетсы", "Хот-дог", "Лазанья"], correctAnswerIndex: 3, sound: "lasagne"),
        Question(interrogative: "Omelette", transcriotion: "[ˈɒmlɪt]", answers: ["Омлет", "Каша", "Бургер", "Яичница"], correctAnswerIndex: 0, sound: "omelette"),
        Question(interrogative: "Pancakes", transcriotion: "[ˈpæŋkeɪk]", answers: ["Пицца", "Блины", "Пирог", "Паста"], correctAnswerIndex: 1, sound: "pancakes"),
        Question(interrogative: "Pasta", transcriotion: "[ˈpæstə]", answers: ["Блины", "Пицца", "Паста", "Пирог"], correctAnswerIndex: 2, sound: "pasta"),
        Question(interrogative: "Pizza", transcriotion: "[ˈpiːtsə]", answers: ["Блины", "Пирог", "Паста", "Пицца"], correctAnswerIndex: 3, sound: "pizza"),
        Question(interrogative: "Pie", transcriotion: "[paɪ]", answers: ["Пирог", "Паста", "Пицца", "Блины"], correctAnswerIndex: 0, sound: "pie"),
        Question(interrogative: "Sandwich", transcriotion: "[ˈsænwɪʤ]", answers: ["Салат", "Сэндвич", "Суши", "Суп"], correctAnswerIndex: 1, sound: "sandwich"),
        Question(interrogative: "Salad", transcriotion: "[ˈsæləd]", answers: ["Суп", "Сэндвич", "Салат", "Суши"], correctAnswerIndex: 2, sound: "salad"),
        Question(interrogative: "Soup", transcriotion: "[suːp]", answers: ["Сэндвич", "Суши", "Салат", "Суп"], correctAnswerIndex: 3, sound: "soup"),
        Question(interrogative: "Sushi", transcriotion: "[ˈsuːʃɪ]", answers: ["Суши", "Салат", "Суп", "Сэндвич"], correctAnswerIndex: 0, sound: "sushi")
    ]
    
    var previouslyUsedNumbers: [Int] = []
    
//MARK: Random
    mutating func getRandomQuestion() -> Question {
        
        var dictionaryCount = iYou
        
        if dictionaryName == "iYouComplex" {
            dictionaryCount = iYouComplex
        } else if dictionaryName == "hello" {
            dictionaryCount = hello
        } else if dictionaryName == "question" {
            dictionaryCount = question
        } else if dictionaryName == "color" {
            dictionaryCount = color
        } else if dictionaryName == "geometricShape" {
            dictionaryCount = geometricShape
        } else if dictionaryName == "number" {
            dictionaryCount = number
        } else if dictionaryName == "numberComplex" {
            dictionaryCount = numberComplex
        } else if dictionaryName == "unitsOfTime" {
            dictionaryCount = unitsOfTime
        } else if dictionaryName == "monthSeason" {
            dictionaryCount = monthSeason
        } else if dictionaryName == "day" {
            dictionaryCount = day
        } else if dictionaryName == "timePeriods" {
            dictionaryCount = timePeriods
        } else if dictionaryName == "person" {
            dictionaryCount = person
        } else if dictionaryName == "family" {
            dictionaryCount = family
        } else if dictionaryName == "body" {
            dictionaryCount = body
        } else if dictionaryName == "feelings" {
            dictionaryCount = feelings
        } else if dictionaryName == "appearance" {
            dictionaryCount = appearance
        } else if dictionaryName == "aboutFood" {
            dictionaryCount = aboutFood
        } else if dictionaryName == "drink" {
            dictionaryCount = drink
        } else if dictionaryName == "drinkReverse" {
            dictionaryCount = drinkReverse
        } else if dictionaryName == "milk" {
            dictionaryCount = milk
        } else if dictionaryName == "milkReverse" {
            dictionaryCount = milkReverse
        } else if dictionaryName == "vegetable" {
            dictionaryCount = vegetable
        } else if dictionaryName == "fruit" {
            dictionaryCount = fruit
        } else if dictionaryName == "nut" {
            dictionaryCount = nut
        } else if dictionaryName == "meat" {
            dictionaryCount = meat
        } else if dictionaryName == "products" {
            dictionaryCount = products
        } else if dictionaryName == "productsReverse" {
            dictionaryCount = productsReverse
        } else if dictionaryName == "sweets" {
            dictionaryCount = sweets
        }  else if dictionaryName == "cookedFood" {
            dictionaryCount = cookedFood
        }
 
        if (previouslyUsedNumbers.count == dictionaryCount.count) {
            previouslyUsedNumbers = []
        }
        
        var randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: dictionaryCount.count)
        
        // Picks a new random number if the previous one has been used
        while (previouslyUsedNumbers.contains(randomNumber)) {
            randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: dictionaryCount.count)
        }
        previouslyUsedNumbers.append(randomNumber)
        
        
        if dictionaryName == "iYouComplex" {
            return iYouComplex[randomNumber]
        } else if dictionaryName == "hello" {
            return hello[randomNumber]
        } else if dictionaryName == "question" {
            return question[randomNumber]
        } else if dictionaryName == "color" {
            return color[randomNumber]
        } else if dictionaryName == "geometricShape" {
            return geometricShape[randomNumber]
        } else if dictionaryName == "number" {
            return number[randomNumber]
        } else if dictionaryName == "numberComplex" {
            return numberComplex[randomNumber]
        } else if dictionaryName == "unitsOfTime" {
            return unitsOfTime[randomNumber]
        } else if dictionaryName == "monthSeason" {
            return monthSeason[randomNumber]
        } else if dictionaryName == "day" {
            return day[randomNumber]
        } else if dictionaryName == "timePeriods" {
            return timePeriods[randomNumber]
        } else if dictionaryName == "person" {
            return person[randomNumber]
        } else if dictionaryName == "family" {
            return family[randomNumber]
        } else if dictionaryName == "body" {
            return body[randomNumber]
        } else if dictionaryName == "feelings" {
            return feelings[randomNumber]
        } else if dictionaryName == "appearance" {
            return appearance[randomNumber]
        } else if dictionaryName == "aboutFood" {
            return aboutFood[randomNumber]
        } else if dictionaryName == "drink" {
            return drink[randomNumber]
        } else if dictionaryName == "drinkReverse" {
            return drinkReverse[randomNumber]
        } else if dictionaryName == "milk" {
            return milk[randomNumber]
        } else if dictionaryName == "milkReverse" {
            return milkReverse[randomNumber]
        } else if dictionaryName == "vegetable" {
            return vegetable[randomNumber]
        } else if dictionaryName == "fruit" {
            return fruit[randomNumber]
        } else if dictionaryName == "nut" {
            return nut[randomNumber]
        } else if dictionaryName == "meat" {
            return meat[randomNumber]
        } else if dictionaryName == "products" {
            return products[randomNumber]
        } else if dictionaryName == "productsReverse" {
            return productsReverse[randomNumber]
        } else if dictionaryName == "sweets" {
            return sweets[randomNumber]
        } else if dictionaryName == "cookedFood" {
            return cookedFood[randomNumber]
        }
        
        return iYou[randomNumber]
    }
//MARK: - inOrder
    mutating func getQuestion() -> Question {
        if dictionaryName == "iYouComplex" {
            return iYouComplex[questionNumber]
        } else if dictionaryName == "hello" {
            return hello[questionNumber]
        } else if dictionaryName == "question" {
            return question[questionNumber]
        } else if dictionaryName == "color" {
            return color[questionNumber]
        } else if dictionaryName == "geometricShape" {
            return geometricShape[questionNumber]
        } else if dictionaryName == "number" {
            return number[questionNumber]
        } else if dictionaryName == "numberComplex" {
            return numberComplex[questionNumber]
        } else if dictionaryName == "unitsOfTime" {
            return unitsOfTime[questionNumber]
        } else if dictionaryName == "monthSeason" {
            return monthSeason[questionNumber]
        } else if dictionaryName == "day" {
            return day[questionNumber]
        } else if dictionaryName == "timePeriods" {
            return timePeriods[questionNumber]
        } else if dictionaryName == "person" {
            return person[questionNumber]
        } else if dictionaryName == "family" {
            return family[questionNumber]
        } else if dictionaryName == "body" {
            return body[questionNumber]
        } else if dictionaryName == "feelings" {
            return feelings[questionNumber]
        } else if dictionaryName == "appearance" {
            return appearance[questionNumber]
        } else if dictionaryName == "aboutFood" {
            return aboutFood[questionNumber]
        } else if dictionaryName == "drink" {
            return drink[questionNumber]
        } else if dictionaryName == "milk" {
            return milk[questionNumber]
        } else if dictionaryName == "vegetable" {
            return vegetable[questionNumber]
        } else if dictionaryName == "fruit" {
            return fruit[questionNumber]
        } else if dictionaryName == "nut" {
            return nut[questionNumber]
        } else if dictionaryName == "meat" {
            return meat[questionNumber]
        } else if dictionaryName == "products" {
            return products[questionNumber]
        } else if dictionaryName == "sweets" {
            return sweets[questionNumber]
        } else if dictionaryName == "cookedFood" {
            return cookedFood[questionNumber]
        }
        return iYou[questionNumber]
    }
    mutating func resetQuestionNumber() {
        questionNumber = 0
    }
}
