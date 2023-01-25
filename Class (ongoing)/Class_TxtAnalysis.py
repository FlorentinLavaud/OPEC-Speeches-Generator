class TxtAnalysis:
    '''
    Includes: 
    cleaning_transcripts()
    remove_stopwords()
    word_cloud()
    '''
    def __init__(self):
        pass 
    
    def check(a):
        print('it is working')

    def opentxtfile(filename):
        with open(filename,'r') as f:
                lines = [line.strip() for line in f if line.strip()]
                transcripts=''.join(lines)
                

    def cleaning_transcripts(transcripts):
        try: 
            transcripts = transcripts.lower()
            transcripts = re.sub('\((.*?\))', '', transcripts)
            transcripts = re.sub('\[.*?\]', '', transcripts)
            transcripts = re.sub('[%s]' % re.escape(string.punctuation), '', transcripts)
            transcripts = re.sub('\w*\d\w*', '', transcripts)
        except: 
            print("An exception occurred")


    def remove_stopwords(transcripts):
        try:
            tokenized_transcripts=word_tokenize(transcripts)
            transcripts_wo_stopwords= [w for w in tokenized_transcripts if not w in stop_words] 
            transcripts_wo_stopwords=' '.join(transcripts_wo_stopwords)  
        except:
            print("An exception occurred") 

    def word_cloud(name,transcript,color_map,x):
        try:
            wc = WordCloud(stopwords=stop_words, width = 300, height = 250,background_color="white", colormap=color_map,
                   max_font_size=75, random_state=60)
            plt.rcParams['figure.figsize'] = [x,x]
            wc.generate(transcript)
            plt.subplot(3,4,3)
            plt.imshow(wc, interpolation="bilinear")
            plt.axis("off")
            plt.title(name)
            plt.show()
        except:
            print("An exception occurred")

